# Preview all emails at http://localhost:3000/rails/mailers/quarantine_mailer
require 'date'
class QuarantineMailerPreview < ActionMailer::Preview
    def quarantine_started_email 
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 4700)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent).quarantine_started_email
    end 

    def quarantine_updated_email 
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 4700)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_updated_email
    end 

    def quarantine_converted_email 
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 4700)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_converted_email
    end 
end
