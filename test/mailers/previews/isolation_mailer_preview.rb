# Preview all emails at http://localhost:3000/rails/mailers/isolation_mailer
require 'date'
class IsolationMailerPreview < ActionMailer::Preview

    def isolation_started_email_student
        isolation = Isolation.new(start_isolation: Date.today, confirmed: true, completed: false, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email_student
    end 

    def isolation_started_email_adult 
        isolation = Isolation.new(start_isolation: Date.today, confirmed: true, end_date: Date.today + 10, completed: false, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email_adult
    end 

    def isolation_updated_email_student
        isolation = Isolation.new(start_isolation: Date.today - 10, confirmed: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_updated_email_student
    end 

    def isolation_updated_email_adult
        isolation = Isolation.new(start_isolation: Date.today - 10, confirmed: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_updated_email_adult
    end 

    def isolation_completed_email_student
        isolation = Isolation.new(start_isolation: Date.today - 10, confirmed: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_completed_email_student
    end 

    def isolation_completed_email_adult
        isolation = Isolation.new(start_isolation: Date.today - 10, confirmed: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_completed_email_adult
    end 

    def potential_isolation_started_email_adult
        isolation = Isolation.new(start_isolation: Date.today - 10, barcode: "ABCDEF", potential: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).potential_isolation_started_email_adult
    end 

    def potential_isolation_started_email_student
        isolation = Isolation.new(start_isolation: Date.today - 10, barcode: "ABCDEF", potential: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).potential_isolation_started_email_student
    end 

    def isolation_potential_to_confirmed_student
        isolation = Isolation.new(start_isolation: Date.today, barcode: "ABCDEF", potential: false, date_improving: Date.today - 10, end_date: Date.today, completed: false, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_potential_to_confirmed_student
    end 

    def isolation_potential_to_confirmed_adult
        isolation = Isolation.new(start_isolation: Date.today, barcode: "ABCDEF", potential: false, date_improving: Date.today - 10, end_date: Date.today, completed: false, student_id: Student.all.first.id)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_potential_to_confirmed_adult
    end
end
