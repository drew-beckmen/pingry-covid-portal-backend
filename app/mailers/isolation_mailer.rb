class IsolationMailer < ApplicationMailer
    default from: 'contacttracing@pingry.org'

    def isolation_started_email_student
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation")
    end  

    def isolation_started_email_adult 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your COVID-19 Isolation")
    end 
    
    def isolation_updated_email_student 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation Update")
    end 

    def isolation_updated_email_adult 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your COVID-19 Isolation Update")
    end 

    def isolation_completed_email_student
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation Complete")
    end 

    def isolation_completed_email_adult
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your Isolation Is Complete")
    end 

    def potential_isolation_started_email_student
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Potentially Positive Case of COVID-19")
    end 

    def potential_isolation_started_email_adult
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Pingry: Potentially Positive Case of COVID-19")
    end 
end
