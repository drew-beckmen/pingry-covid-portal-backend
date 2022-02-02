# Preview all emails at http://localhost:3000/rails/mailers/quarantine_mailer
require 'date'
class ContactMailerPreview < ActionMailer::Preview
    def contact_student
        contact = Contact.new(exposure: Date.today, student_id: 1, recent_recovery: true)
        currentStudent = Student.find(contact.student_id)
        ContactMailer.with(student: currentStudent, contact: contact).contact_student 
    end 

    def contact_adult
        contact = Contact.new(exposure: Date.today, student_id: 1)
        currentStudent = Student.find(contact.student_id)
        ContactMailer.with(student: currentStudent, contact: contact).contact_adult 
    end 
end
