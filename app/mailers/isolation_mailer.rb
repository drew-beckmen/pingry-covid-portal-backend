class IsolationMailer < ApplicationMailer
    default from: 'drewb2000@gmail.com'

    def isolation_started_email 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "TEST EMAIL - Pingry: #{@student.first_name} COVID-19 Isolation")
    end  
    
    def isolation_updated_email 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "TEST EMAIL - Pingry: #{@student.first_name} COVID-19 Isolation Update")
    end 
end
