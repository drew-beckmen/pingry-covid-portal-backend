class Api::V1::UsersController < ApplicationController
    skip_before_action :write_access, only: [:update]
    def show 
        user = User.find(params[:id])
        render json: user
    end 

    def update 
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end 

    private 
    def user_params 
        params.require(:user).permit(:username, :password, :write)
    end 
end
