class QuarantineMailer < ApplicationMailer 
    default from: 'noreply@pingry.org'
    def quarantine_started_email
        @student = params[:student]
        if !@student.teacher
            mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "TEST EMAIL - Pingry: #{@student.first_name} COVID-19 Update")
        else 
            mail(to: @student.email, subject: "TEST EMAIL IGNORE - Pingry: #{@student.first_name} COVID-19 Quarantine Update")
        end 
        # mail(to: "dfahey@pingry.org", subject: "TEST EMAIL - Pingry: #{@student.first_name} COVID-19 Update")
    end 

    def quarantine_updated_email 
        @student = params[:student]
        @quarantine = params[:quarantine]
        if !@student.teacher
            mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "TEST EMAIL - Pingry: #{@student.first_name} Quarantine Update")
        else 
            mail(to: @student.email, subject: "TEST EMAIL IGNORE - Pingry: #{@student.first_name} COVID-19 Isolation")
        end 
        # mail(to: "dfahey@pingry.org", subject: "TEST EMAIL - Pingry: #{@student.first_name}'s Quarantine Update")
    end

    def quarantine_converted_email 
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "TEST EMAIL - Pingry: #{@student.first_name}'s' Quarantine Converted To Isolation" )
    end 
end 