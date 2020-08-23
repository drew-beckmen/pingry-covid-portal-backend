class QuarantineMailer < ApplicationMailer 
    default from: 'apu@pingry.com'

    def quarantine_started_email
        @student = params[:student]
        mail(to: "drew.beckmen@yale.edu", subject: "Pingry: #{@student.first_name} COVID-19 Update")
    end 

    def quarantine_updated_email 
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "drew.beckmen@yale.edu", subject: "Pingry: #{@student.first_name} Quarantine Update")
    end 
    
end 