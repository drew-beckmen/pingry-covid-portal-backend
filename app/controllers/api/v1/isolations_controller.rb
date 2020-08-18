class Api::V1::IsolationsController < ApplicationController
    def update 
        isolation = Isolation.find(params[:id])
        isolation.update(isolation_params)
        render json: isolation
    end 

    def show 
        isolation = Isolation.find(params[:id])
        render json: isolation
    end 

    def destroy 
        isolation = Isolation.find(params[:id])
        isolation.destroy 
        render json: "Deleted successfully"
    end 

    def index 
        isolations = Isolation.all 
        render json: isolations
    end 

    def create 
        isolation = Isolation.create(isolation_params)
        render json: isolation
    end 

    private 
    def isolation_params 
        params.require(:isolation).permit(:start_isolation, :date_improving, :fever_free, :end_date, :completed, :student_id)
    end 
end
