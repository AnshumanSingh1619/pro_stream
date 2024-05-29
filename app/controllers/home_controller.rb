class HomeController < ApplicationController
  before_action :authenticate
  before_action :set_content, only: [:showcontent, :showseason]
  include ApplicationHelper

  def index
    @contents = @mcontents.page(params[:page]).per(50)
  end
  
  def showcontent
  end

  def showseason
    @season = @content.seasons.find(params[:season_id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('showseason', partial: "shared/show_season", locals: { changed_season: @season })
      end
    end    
  end
  

  def seasondestroy
    content = @mcontents.find(params[:content_id])
    season = content.seasons.find(params[:season_id])
    season.destroy
    redirect_to content_path(content), notice: "Season was successfully destroyed."
  end

  def episodedestroy
    content = @mcontents.find(params[:content_id])
    season = content.seasons.find(params[:season_id])
    episode = season.episodes.find(params[:episode_id])
    episode.destroy
    redirect_to content_path(content), notice: "Episode was successfully destroyed."
  end

  private

  def set_content 
    @content = @mcontents.find(params[:content_id])
  end

  def set_season
    @season = @content.seasons.find(params[:season_id])
  end

  def authenticate 
    if admin_signed_in? 
      @mcontents = Content.includes(seasons: :episodes, poster_attachment: :blob, movie_attachment: :blob, trailer_attachment: :blob).all
    elsif user_signed_in?
      user_authenticate
    else
      redirect_to new_user_session_path 
    end 
  end
end
