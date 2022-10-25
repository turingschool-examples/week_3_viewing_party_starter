class SessionsController < ApplicationController 
    def new
    end 

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to "/dashboard"
        else 
            flash[:error] = "Bad Credentials, try again."
            redirect_to "/login" 
        end 
    end 

    def destroy 
        session.delete(:user_id)
        redirect_to root_path
    end 

end 