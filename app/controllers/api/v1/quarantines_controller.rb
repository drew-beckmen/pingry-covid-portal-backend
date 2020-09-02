class Api::V1::QuarantinesController < ApplicationController
    def update 
        quarantine = Quarantine.find(params[:id])
        quarantine.update(quarantine_params)
        currentStudent = Student.find(quarantine.student_id)
        if quarantine.converted_to_isolation
            QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_converted_email.deliver_now
        else 
            QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_updated_email.deliver_now
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
        QuarantineMailer.with(student: currentStudent).quarantine_started_email.deliver_now
        render json: quarantine
    end 

    private 
    def quarantine_params 
        params.require(:quarantine).permit(:id, :exposure, :completed, :student_id, :notes, :converted_to_isolation)
    end 
end
