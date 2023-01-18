class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]     

    def create 
        @user = User.new(user_params)
        if @user.save 
            redirect_to users_url
        else
            render json: @user.errors.full_messages, status: 422 
    end

    private 

    def user_params
        params.require(:user).permit(:username, :email, :age, :password)
    end
end
