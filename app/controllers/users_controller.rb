class UsersController <ApplicationController 
    before_action :require_user, only: :show
    def new 
        @user = User.new()
    end 

    def show 
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

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password)
    end 

    def require_user
        if !current_user 
            flash[:error] = 'You must be a registered user to access this page'
            redirect_to '/'
        end 
    end 
end 