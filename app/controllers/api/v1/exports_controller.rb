class Api::V1::ExportsController < ApplicationController
    
    def data_export
        DataExport.generate_csv
        ExportMailer.with(user: current_user).send_csv_data_export.deliver_now
        render json: {}, status: 200
    end
end
