class HomeController < ApplicationController
  before_action :authenticate
  before_action :set_content, only: [:showcontent, :showseason]
  before_action :set_season, only: [:showseason]
  include ApplicationHelper

  def index
    @allcontents = @mcontents
  end
  
  def showcontent
  end

  def showseason
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
      @mcontents = Content.all
    elsif user_signed_in?
      user_authenticate
    else
      redirect_to new_user_session_path 
    end 
  end
end
