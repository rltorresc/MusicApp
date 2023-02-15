class NotesController < ApplicationController
    before_action :require_login
    before_action :set_current_user
    def new
        @note = Note.new
        @track = Track.find(params[:track_id])
        @user = User.find(params[:user_id])
    end

    def create
        @note = Note.new(note_params)
        @note.user_id = @current_user.id
        if @note.save
            redirect_to track_url(@note.track)
        else
            flash.now[:errors] = @note.errors.full_messages
            render :new
        end
    end

    def destroy
        @note = Note.find(params[:id])
        if @note.user_id == @current_user.id || @current_user.admin?
            @note.destroy
            redirect_to track_url(@note.track)
        else
            flash[:alert] = "You can't delete someone else's note!"
            redirect_to track_url(@note.track)
        end
    end

    private
    def note_params
        params.require(:note).permit(:track_id, :user_id, :notes)
    end

end
