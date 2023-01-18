class SessionsController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]

    def new
        render :new
    end

    def create
        # does a user exist with that username? 
        # if found, do the password match? 
        # if match, then create a new session 
        # creating a session is just matching up session_token to a token in the cookies 
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if user 
            # create s_t key in the session object, equal to users token 
            session[:session_token] = user.reset_session_token!
            redirect_to users_url 
        else
            # user is nil or not found 
            render json: ["Invalid Credentials"] 
        end
    end

    def destroy
        logout!
        redirect_to new_session_url 
    end
end
