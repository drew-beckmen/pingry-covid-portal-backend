class ExportMailer < ApplicationMailer 
    default from: 'contacttracing@pingry.org'
    def send_csv_data_export
        @user = params[:user]
        attachments['covid_data_export' + '.csv'] = File.read('app/mailers/covid_data_export.csv')
        mail(to: @user.username + '@pingry.org', reply_to: "contacttracing@pingry.org", subject: "Pingry Covid-19 Data Export for #{Date.today}")
    end 
end