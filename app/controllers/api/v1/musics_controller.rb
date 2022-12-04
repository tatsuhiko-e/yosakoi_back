class Api::V1::MusicsController < ApplicationController
  def index
    musics = Music.where(admin_id: current_api_v1_admin.id).sort_by { |a| a.active ? 0 : 1 }

    render json: musics, methods: [:audio_url]
  end

  def show
    music = Music.find(params[:id])
    render json: music, methods: [:audio_url]
  end

  def create
    music = Music.new(music_params)
    music.admin_id = current_api_v1_admin.id
    if music.save
      render json: { status: :ok, data: music }
    else
      render json: { status: :bad_request, data: errors }
    end
  end

  def update
    music = Music.find(params[:id])
    if music.update(music_params)
      render json: { status: :ok, data: music }
    else
      render json: { status: :bad_request, data: errors }
    end
  end

  def search
    musics = Music.where(admin_id: current_api_v1_admin.id).sort_by { |a| a.active ? 0 : 1 }
    search_music = musics.select { |e| e.title =~ %r{^.*#{params[:search_title]}.*} }
    render json: search_music
  end

  private

  def set_musics
    musics = Music.where(admin_id: current_api_v1_admin.id).sort_by { |a| a.active ? 0 : 1 }
  end

  def music_params
    params.require(:music).permit(:title, :theme, :active, :release_year, :admin_id, :music_file)
  end
end
