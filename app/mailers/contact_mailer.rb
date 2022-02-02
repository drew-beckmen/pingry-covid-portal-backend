class ContactMailer < ApplicationMailer 
    default from: 'contacttracing@pingry.org'
    def contact_student
        @student = params[:student]
        @contact = params[:contact]
        subject = @contact.recent_recovery ? "Pingry COVID-19 Exposure Alert (no action required)" : "Pingry COVID-19 Exposure Alert (testing recommended)"
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: subject, :content_type => 'text/html')
    end 

    def contact_adult 
        @student = params[:student]
        @contact = params[:contact]
        subject = @contact.recent_recovery ? "Pingry COVID-19 Exposure Alert (no action required)" : "Pingry COVID-19 Exposure Alert (testing recommended)"
        mail(to: @student.email, subject: subject, reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", :content_type => 'text/html')
    end
end 