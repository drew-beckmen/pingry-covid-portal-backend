# Preview all emails at http://localhost:3000/rails/mailers/quarantine_mailer
require 'date'
class QuarantineMailerPreview < ActionMailer::Preview
    def quarantine_started_email_student
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1, end_date: Date.today + 20)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_started_email_student 
    end 

    def quarantine_started_email_adult
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_started_email_adult 
    end 

    def quarantine_updated_email_student
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_updated_email_student
    end 

    def quarantine_updated_email_adult
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_updated_email_adult
    end 

    def quarantine_converted_email_student
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_converted_email_student
    end 

    def quarantine_converted_email_adult
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_converted_email_adult
    end 

    def quarantine_completed_email_student
        quarantine = Quarantine.new(exposure: Date.today - 14, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_completed_email_student
    end 

    def quarantine_completed_email_adult 
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_completed_email_adult
    end 

    def quarantine_testing_email_student
        quarantine = Quarantine.new(exposure: Date.today - 14, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_testing_email_student
    end 

    def quarantine_testing_email_adult 
        quarantine = Quarantine.new(exposure: Date.today, completed: false, student_id: 1)
        currentStudent = Student.find(quarantine.student_id)
        QuarantineMailer.with(student: currentStudent, quarantine: quarantine).quarantine_testing_email_adult
    end 
end
