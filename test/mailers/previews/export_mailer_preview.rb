require 'date'
class ExportMailerPreview < ActionMailer::Preview
    def send_csv_data_export
        @user = User.all.first
        ExportMailer.with(user: @user).send_csv_data_export 
    end 
end
