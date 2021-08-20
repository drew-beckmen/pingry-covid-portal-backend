class Api::V1::ContactsController < ApplicationController
    def show 
        contact = Contact.find(params[:id])
        render json: contact
    end 

    def destroy 
        contact = Contact.find(params[:id])
        contact.destroy 
        render json: "Deleted Successfully!"
    end 

    def index
        contacts = Contact.all
        render json: contacts
    end 

    def create 
        contact = Contact.create(contact_params)
        currentStudent = Student.find(contact.student_id)
        # TODO: add email functionality for contacts
        if !currentStudent.teacher
            ContactMailer.with(student: currentStudent, contact: contact).contact_student.deliver_now
        else 
            ContactMailer.with(student: currentStudent, contact: contact).contact_adult.deliver_now
        end 
        render json: contact
    end

    private 
    def contact_params 
        params.require(:contact).permit(:id, :exposure, :student_id, :notes)
    end 
end
