class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token 
    # before the action goes through, we're running above action to prevent hackers intercepting the request 
    # when working on your real app, take this out before production, otherwise people will know you dont know how to protect your app 

    # need this for views 
    helper_method :current_user, :logged_in? 

# LOG IN ---------------------------------------------------------------------------------
    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def current_user
        return nil if session[:session_token].nil? 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
    #     if current_user
    #         return true
    #     else
    #         return false
    #     end
    # end
        !!current_user # fancy 
    end

# LOG OUT ----------------------------------------------------------------------------------
    def logout!
        # reset current_users session 
        current_user.reset_session_token! if logged_in?
        # nillify the previous session token 
        session[:session_token] = nil 
        @current_user = nil 
    end

    def require_logged_in
        redirect_to new_mession_url unless logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

end
