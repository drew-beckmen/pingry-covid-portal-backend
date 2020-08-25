# Preview all emails at http://localhost:3000/rails/mailers/isolation_mailer
require 'date'
class IsolationMailerPreview < ActionMailer::Preview

    def isolation_started_email 
        isolation = Isolation.new(start_isolation: Date.today, confirmed: true, end_date: Date.today + 10, completed: false, student_id: 1)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_started_email
    end 

    def isolation_updated_email 
        isolation = Isolation.new(start_isolation: Date.today - 10, confirmed: true, date_improving: Date.today - 10, end_date: Date.today, completed: true, student_id: 1)
        currentStudent = Student.find(isolation.student_id)
        IsolationMailer.with(student: currentStudent, isolation: isolation).isolation_updated_email
    end 
end
