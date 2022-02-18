class QuarantineMailer < ApplicationMailer 
    default from: 'contacttracing@pingry.org'
    def quarantine_started_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Your Child’s Mandatory Quarantine Period has Started", :content_type => 'text/html')
    end 

    def quarantine_started_email_adult 
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, subject: "Mandatory Quarantine Period has Started", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", :content_type => 'text/html')
    end

    def quarantine_updated_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s Quarantine Update", :content_type => 'text/html')
    end

    def quarantine_updated_email_adult 
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, subject: "Pingry: Your Quarantine Update", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", :content_type => 'text/html')
    end 

    def quarantine_converted_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s Quarantine Converted To Isolation", :content_type => 'text/html')
    end 

    def quarantine_converted_email_adult
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Quarantine Converted To Isolation", :content_type => 'text/html')
    end 

    def quarantine_completed_email_student
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s Quarantine Is Complete", :content_type => 'text/html')
    end 

    def quarantine_completed_email_adult
        @student = params[:student]
        @quarantine = params[:quarantine]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your Quarantine Is Complete", :content_type => 'text/html')
    end 

end 