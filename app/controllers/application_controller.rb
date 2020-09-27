class ApplicationController < ActionController::API
    prepend_before_action :authorized
    before_action :write_access

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
        puts decoded_token 
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end 
    end 

    def logged_in? 
        !!current_user
    end

    def write? 
        if current_user
            current_user.write 
        end 
    end 

    def write_access
        puts "WRITE"
        render json: { message: "Denied Access" }, status: :unauthorized unless write? 
    end 

    def authorized
        puts "PASSWORD"
        render json: { message: "Please Log In" }, status: :unauthorized unless logged_in? 
    end 
end
