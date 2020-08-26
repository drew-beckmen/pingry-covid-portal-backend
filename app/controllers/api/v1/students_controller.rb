class Api::V1::StudentsController < ApplicationController
    def update 
        student = Student.find(params[:id])
        student.update(student_params)
        render json: student
    end 

    def show 
        student = Student.find(params[:id])
        render json: student
    end 

    def index 
        students = Student.all 
        render json: students 
    end 

    def info 
        list = Student.all.map{|s| {:label => "#{s.first_name} #{s.last_name}", :value => s.id}}
        render json: list 
    end 

    private
    def student_params 
        params.require(:student).permit(:first_name, :last_name, :grade, :campus, :cohort, :veracross_id, :teacher, :email)
    end 
end
