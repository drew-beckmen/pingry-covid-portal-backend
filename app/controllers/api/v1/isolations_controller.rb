class Api::V1::IsolationsController < ApplicationController
    def update 
        isolation = Isolation.find(params[:id])
        params = isolation_params

        if params.isolation.start_isolation == isolation.start_isolation && params.isolation.date_improving == isolation.date_improving && params.isolation.fever_free == isolation.fever_free && params.isolation.end_date == isolation.end_date && params.isolation.completed == isolation.completed && params.isolation.confirmed == isolation.confirmed
            isolation.update(isolation_params)
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
            IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email_student.deliver_now
        else 
            IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email_adult.deliver_now
        end 
        render json: isolation
    end 

    private 
    def isolation_params 
        params.require(:isolation).permit(:start_isolation, :date_improving, :fever_free, :end_date, :completed, :student_id, :notes, :confirmed)
    end 
end
