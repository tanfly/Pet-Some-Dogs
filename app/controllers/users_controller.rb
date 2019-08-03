class UsersController < ApplicationController

    def show
        if current_user
            @user = current_user
            render :show
        else
            redirect_to root_path
        end
    end

    def new
        @user = User.new
    end

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else
            flash[:message] = "Please ensure all form areas are filled correctly"
            redirect_to new_user_path
        end
    end

    def edit
        @user = current_user
    end

    def update
        
    end

    private

    def user_params
        params.require(:user).permit(:name, :username, :password_digest, :email, :last_login, :member_since, :age, :location, :avatar)
    end
end
