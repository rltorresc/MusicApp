class AlbumsController < ApplicationController
    before_action :require_login
    before_action :check_admin, only: [:edit, :update, :destroy, :new, :create]
    def new
        @album = Album.new
        @album.band_id = params[:band_id]
    end

    def show
        @band = Album.find(params[:id]).band
        @album = Album.find(params[:id])
        render :show
    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new
        end
    end

    def edit
        @album = Album.find(params[:id])
        render :edit
    end

    def update 
        @album = Album.find(params[:id])
        if @album.update(album_params)
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :edit
        end
    end
    
    def destroy
        @album = Album.find(params[:id])
        @album.destroy
        redirect_to band_url(@album.band)
    end

    private
    def album_params
        params.require(:album).permit(:band_id, :title, :year, :live)
    end
end
