class UsersController < ApplicationController
    before_action :check_admin, only: [:index]
    def index
        @users = User.all
        render :index
    end
    
    # This is a new method that creates a new user.
    def new
        @user = User.new
        render :new
    end
    #This is a create method that saves the user.
    def create
        @user = User.new(user_params)
        if @user.save
            send_activation_email(@user)
            log_in_user!(@user)
            redirect_to bands_url
        else
            flash[:alert] = "That email is already taken."
            redirect_to new_user_url
        end
    end
    # This is a show method that displays the user's email.
    def show
        @user = User.where(user_id: current_user.id)
        render :show
    end

    def activate
        @user = User.find_by(activation_token: params[:activation_token])
        if @user && @user.activation_token == params[:activation_token]
            @user.activated = true
            @user.save
            log_in_user!(@user)
            redirect_to bands_url
        else
            flash[:alert] = "Invalid
            activation token"
            redirect_to new_user_url
        end
    end

    def send_activation_email(user)
        @activation_token = SecureRandom.urlsafe_base64
        @user.activation_token = @activation_token
        @user.save
        msg = UserMailer.welcome_email(user)
        msg.deliver_now
    end

    def make_admin
        @user = User.find(params[:id])
        @user.admin = true
        @user.save
        redirect_to users_url
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
