class Api::V1::QuarantinesController < ApplicationController
    def update 
        quarantine = Quarantine.find(params[:id])

        # don't want to send email if only update is notes
        params = quarantine_params 
        if params["quarantine"]["exposure"] == quarantine.exposure && params["quarantine"]["completed"] == quarantine.completed && params["quarantine"]["converted_to_isolation"] == quarantine.converted_to_isolation
            quarantine.update(quarantine_params)
        else 
            quarantine.update(quarantine_params)
            currentStudent = Student.find(quarantine.student_id)
            if quarantine.converted_to_isolation
                if !currentStudent.teacher 
                    QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_converted_email_student.deliver_now
                else 
                    QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_converted_email_adult.deliver_now
                end 
            else 
                if !currentStudent.teacher
                    if quarantine.completed
                        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_completed_email_student.deliver_now
                    else 
                        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_updated_email_student.deliver_now
                    end 
                else 
                    if quarantine.completed 
                        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_completed_email_adult.deliver_now
                    else 
                        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_updated_email_adult.deliver_now
                    end 
                end 
            end
        end  
        render json: quarantine
    end 

    def show 
        quarantine = Quarantine.find(params[:id])
        render json: quarantine
    end 

    def destroy 
        quarantine = Quarantine.find(params[:id])
        quarantine.destroy 
        render json: "Deleted Successfully!"
    end 

    def index
        quarantines = Quarantine.all
        render json: quarantines
    end 

    def create 
        quarantine = Quarantine.create(quarantine_params)
        currentStudent = Student.find(quarantine.student_id)
        if !currentStudent.teacher
            QuarantineMailer.with(student: currentStudent).quarantine_started_email_student.deliver_now
        else 
            QuarantineMailer.with(student: currentStudent).quarantine_started_email_adult.deliver_now
        end 
        render json: quarantine
    end 

    private 
    def quarantine_params 
        params.require(:quarantine).permit(:id, :exposure, :completed, :student_id, :notes, :converted_to_isolation)
    end 
end
