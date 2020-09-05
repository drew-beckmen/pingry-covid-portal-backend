class QuarantineMailer < ApplicationMailer 
    default from: 'ecarannante@pingry.org'
    def quarantine_started_email_student
        @student = params[:student]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "Pingry: #{@student.first_name}'s Quarantine Period Start")
    end 

    def quarantine_started_email_adult 
        @student = params[:student]
        mail(to: @student.email, subject: "Pingry: Quarantine Period Started")
    end

    def quarantine_updated_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "Pingry: #{@student.first_name}'s Quarantine Update")
    end

    def quarantine_updated_email_adult 
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, subject: "Pingry: Your Quarantine Update")
    end 

    def quarantine_converted_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "Pingry: #{@student.first_name}'s Quarantine Converted To Isolation")
    end 

    def quarantine_converted_email_adult
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, subject: "Pingry: Quarantine Converted To Isolation")
    end 

    def quarantine_completed_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", subject: "Pingry: #{@student.first_name}'s Quarantine Is Complete")
    end 

    def quarantine_completed_email_adult
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, subject: "Pingry: Your Quarantine Is Complete")
    end 

end 