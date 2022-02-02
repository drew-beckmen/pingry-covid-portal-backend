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
        latestIsolation = Isolation.where(student_id: currentStudent, confirmed: true).sort_by(&:created_at)&.last&.created_at
        if !latestIsolation.nil? && latestIsolation >= 90.days.ago 
            contact.recent_recovery = true
        else
            contact.recent_recovery = false
        end
        contact.save
        if !currentStudent.teacher
            ContactMailer.with(student: currentStudent, contact: contact).contact_student.deliver_now
        else 
            ContactMailer.with(student: currentStudent, contact: contact).contact_adult.deliver_now
        end 
        render json: contact
    end

    private 
    def contact_params 
        params.require(:contact).permit(:id, :exposure, :student_id, :notes, :recent_recovery)
    end 
end
