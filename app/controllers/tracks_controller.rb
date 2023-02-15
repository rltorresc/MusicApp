class TracksController < ApplicationController
    before_action :require_login
    before_action :check_admin, only: [:edit, :update, :destroy, :new, :create]
    def new 
        @track = Track.new
        @track.album_id = params[:album_id]
        render :new
    end

    def create
        @track = Track.new(track_params)
        if @track.save
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :new
        end
    end

    def show
        @album = Track.find(params[:id]).album
        @track = Track.find(params[:id])
        render :show
    end

    def edit
        @track = Track.find(params[:id])
        render :edit
    end

    def update
        @track = Track.find(params[:id])
        if @track.update(track_params)
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :edit
        end
    end

    def destroy
        @track = Track.find(params[:id])
        @track.destroy
        redirect_to album_url(@track.album)
    end

    private

    def track_params
        params.require(:track).permit(:album_id, :title, :ord, :regular, :lyrics)
    end
end
