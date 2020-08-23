class IsolationMailer < ApplicationMailer
    default from: 'apu@pingry.com'

    def isolation_started_email 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "drew.beckmen@yale.edu", subject: "Pingry: #{@student.first_name} COVID-19 Isolation")
    end  
    
    def isolation_updated_email 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "drew.beckmen@yale.edu", subject: "Pingry: #{@student.first_name} COVID-19 Isolation Update")
    end 
end
