class Api::V1::IsolationsController < ApplicationController
    def update 
        isolation = Isolation.find(params[:id])
        params = isolation_params

        # Don't send email when just notes are updated.
        if Date.parse(params[:start_isolation]) == isolation.start_isolation && 
            ((params[:date_improving].nil? && isolation.date_improving.nil?) || Date.parse(params[:date_improving]) == isolation.date_improving) && 
            params[:fever_free] == isolation.fever_free && ((params[:end_date].nil? && isolation.end_date.nil?) || Date.parse(params[:end_date]) == isolation.end_date) && 
            params[:completed] == isolation.completed && params[:confirmed] == isolation.confirmed && 
            params[:potential] == isolation.potential
            isolation.update(isolation_params)
        elsif isolation.potential && params[:confirmed]
            puts("HERE")
            isolation.update(isolation_params)
            currentStudent = Student.find(isolation.student_id)
            if !currentStudent.teacher
                IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_potential_to_confirmed_student.deliver_now
            else
                IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_potential_to_confirmed_adult.deliver_now
            end
        else 
            isolation.update(isolation_params)
            currentStudent = Student.find(isolation.student_id)
            if !currentStudent.teacher 
                if isolation.completed 
                    IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_completed_email_student.deliver_now
                else 
                    IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_updated_email_student.deliver_now
                end 
            else 
                if isolation.completed 
                    IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_completed_email_adult.deliver_now
                else 
                    IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_updated_email_adult.deliver_now
                end 
            end 
        end 
        render json: isolation
    end 

    def show 
        isolation = Isolation.find(params[:id])
        render json: isolation
    end 

    def destroy 
        isolation = Isolation.find(params[:id])
        isolation.destroy 
        render json: "Deleted successfully"
    end 

    def index 
        isolations = Isolation.all 
        render json: isolations
    end 

    def create 
        isolation = Isolation.create(isolation_params)
        currentStudent = Student.find(isolation.student_id)
        if !currentStudent.teacher
            if isolation.potential
                IsolationMailer.with(student: currentStudent, isolation: isolation).potential_isolation_started_email_student.deliver_now
            else 
                IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email_student.deliver_now
            end 
        else 
            if isolation.potential 
                IsolationMailer.with(student: currentStudent, isolation: isolation).potential_isolation_started_email_adult.deliver_now
            else 
                IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email_adult.deliver_now
            end 
        end 
        render json: isolation
    end 

    private 
    def isolation_params 
        params.require(:isolation).permit(:start_isolation, :date_improving, :fever_free, :end_date, :completed, :student_id, :notes, :confirmed, :potential, :barcode)
    end 
end
