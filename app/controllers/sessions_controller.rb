class SessionsController < ApplicationController

    # This is a new method that creates a new session.
    def new 
        render :new
    end
    # This is a create method that saves the session.
    def create
        @user = User.find_by_credentials(session_params[:email], session_params[:password])
        if @user
            log_in_user!(@user)
            redirect_to bands_url
        else
            flash[:alert] = "Invalid username or password"
            redirect_to new_session_url
        end
    end
    # This is a destroy method that destroys the session.
    def destroy
        logout!
        redirect_to new_session_url
    end

    private

    def session_params
        params.require(:user).permit(:email, :password)
    end
end
