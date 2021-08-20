class ContactMailer < ApplicationMailer 
    default from: 'contacttracing@pingry.org'
    def contact_student
        @student = params[:student]
        @contact = params[:contact]
        mail(to: "pingry.parents_and_#{@student.veracross_id}@mail.veracross.com", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", subject: "Pingry: #{@student.first_name}'s Close Contact", :content_type => 'text/html')
    end 

    def contact_adult 
        @student = params[:student]
        @contact = params[:contact]
        mail(to: @student.email, subject: "Pingry: Close Contact", reply_to: "contacttracing@pingry.org", cc: "contacttracing@pingry.org", :content_type => 'text/html')
    end
end 