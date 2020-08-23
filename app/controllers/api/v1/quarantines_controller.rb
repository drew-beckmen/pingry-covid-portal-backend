class Api::V1::QuarantinesController < ApplicationController
    def update 
        quarantine = Quarantine.find(params[:id])
        quarantine.update(quarantine_params)
        render json: quarantine
    end 

    def show 
        quarantine = Quarantine.find(params[:id])
        render json: quarantine
    end 

    def destroy 
        quarantine = Quarantine.find(params[:id])
        quarantine.destroy 
        render json: "Deleted Successfully!"
    end 

    def index
        quarantines = Quarantine.all 
        render json: quarantines
    end 

    def create 
        quarantine = Quarantine.create(quarantine_params)
        render json: quarantine
    end 

    private 
    def quarantine_params 
        params.require(:quarantine).permit(:exposure, :completed, :student_id, :notes)
    end 
end
