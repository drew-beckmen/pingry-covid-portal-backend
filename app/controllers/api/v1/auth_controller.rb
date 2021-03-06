# give users a token when they log in
class Api::V1::AuthController < ApplicationController
    #is this working?
    skip_before_action :authorized, only: [:create]
    skip_before_action :write_access, only: [:create]
    def create 
        @user = User.find_by(username: user_login_params[:username])
        if @user && @user.authenticate(user_login_params[:password])
            token = encode_token({user_id: @user.id })
            render json: { user: UserSerializer.new(@user), jwt: token}, status: :accepted 
        else 
            render json: { message: 'Invalid username or password' }, status: :unauthorized 
        end 
    end 

    private 
    def user_login_params
        params.require(:user).permit(:username, :password)
    end 
end


