class Api::V1::ExportsController < ApplicationController
    
    def data_export
        DataExport.generate_csv
        ExportMailer.with(user: currentUser).send_csv_data_export.deliver_now
    end
end
