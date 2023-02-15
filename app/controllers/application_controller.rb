class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :log_in_user!
    # This is a method that checks if there is a user logged in.
    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end
    # This is a method that checks if the user is logged in.
    def logged_in?
        !!current_user
    end
    # This is a method that logs in the user.
    def log_in_user!(user)
        session[:session_token] = user.reset_session_token!
        cookies.signed[:session_token] = { value: user.session_token, expires: 2.day.from_now}
    end
    # This is a method that logs out the user.
    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
        cookies.signed[:session_token] = nil
    end
   
    def require_login
        redirect_to new_session_url unless logged_in?
    end

    def set_current_user
        @current_user = current_user
    end

    def check_admin
        unless current_user.admin?
            redirect_to bands_url, flash: { alert: "You are not an admin!"}
        end
    end

end
