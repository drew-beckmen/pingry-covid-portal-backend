class IsolationMailer < ApplicationMailer
    default from: 'contacttracing@pingry.org'

    def isolation_started_email_student
        @student = params[:student]
        @isolation = params[:isolation]
        # attachments['covid_clearance' + '.pdf'] = File.read('app/mailers/covid_clearance.pdf')
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation")
    end  

    def isolation_started_email_adult 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your COVID-19 Isolation", :content_type => 'text/html')
    end 
    
    def isolation_updated_email_student 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation Update", :content_type => 'text/html')
    end 

    def isolation_updated_email_adult 
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your COVID-19 Isolation Update", :content_type => 'text/html')
    end 

    def isolation_completed_email_student
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation Complete", :content_type => 'text/html')
    end 

    def isolation_completed_email_adult
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your Isolation Is Complete", :content_type => 'text/html')
    end 

    def potential_isolation_started_email_student
        @student = params[:student]
        @isolation = params[:isolation]
        # attachments['meenta_instructions' + '.pdf'] = File.read('app/mailers/Meenta.io.pdf')
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Potentially Positive Case of COVID-19")
    end 

    def potential_isolation_started_email_adult
        @student = params[:student]
        @isolation = params[:isolation]
        # attachments['meenta_instructions' + '.pdf'] = File.read('app/mailers/Meenta.io.pdf')
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Potentially Positive Case of COVID-19")
    end

    def isolation_potential_to_confirmed_student
        @student = params[:student]
        @isolation = params[:isolation]
        # attachments['covid_clearance' + '.pdf'] = File.read('app/mailers/covid_clearance.pdf')
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s COVID-19 Isolation")
    end

    def isolation_potential_to_confirmed_adult
        @student = params[:student]
        @isolation = params[:isolation]
        mail(to: @student.email, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: Your COVID-19 Isolation")
    end
end
