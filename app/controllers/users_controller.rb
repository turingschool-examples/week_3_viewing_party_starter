class UsersController <ApplicationController 
    def new 
        @user = User.new()
    end 

    def show 
        if session[:user_id] 
            @user = User.find(session[:user_id])
        end
    end 

    def create 
        user = User.create(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to dashboard_path
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    def login_form

    end 

    def login_user
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to "/dashboard"
        else 
            flash[:error] = "Bad Credentials, try again."
            redirect_to "/login" 
        end 
    end 

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password)
    end 
end 