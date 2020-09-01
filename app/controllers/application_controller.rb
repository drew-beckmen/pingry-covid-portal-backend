class ApplicationController < ActionController::API
    before_action :authorized #, :write_access

    def encode_token(payload)
        JWT.encode(payload, ENV['JWT_SECRET_KEY'])
    end 

    def auth_header 
        request.headers['Authorization'] #expecting { 'Authorization': 'Bearer <token>' }
    end 

    def decoded_token
        if auth_header
            token = auth_header.split(" ")[1]
            begin
                JWT.decode(token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256')
            rescue JWT::DecodeError 
                nil 
            end
        end 
    end 

    def current_user 
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end 
    end 

    def logged_in? 
        !!current_user
    end

    # def write_access
    #     render json: { message: "Unauthorized User"}, status: :unauthorized unless current_user.write 
    # end 

    def authorized
        render json: { message: "Please log in" }, status: :unauthorized unless logged_in?
    end 
end
