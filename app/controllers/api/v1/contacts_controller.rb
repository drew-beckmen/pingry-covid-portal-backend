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
        # if !currentStudent.teacher
        #     QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_started_email_student.deliver_now
        #     # QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_testing_email_student.deliver_now
        # else 
        #     QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_started_email_adult.deliver_now
        #     # QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_testing_email_adult.deliver_now
        # end 
        render json: contact
    end

    private 
    def contact_params 
        params.require(:contact).permit(:id, :exposure, :student_id, :notes)
    end 
end
