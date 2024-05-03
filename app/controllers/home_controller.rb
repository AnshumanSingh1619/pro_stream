class HomeController < ApplicationController
  before_action :authenticate
  before_action :set_content, only: [:showcontent, :showseason, :seasondestroy, :episodedestroy]
  before_action :set_season, only: [:showseason, :seasondestroy, :episodedestroy,]
  before_action :set_episode, only: [:episodedestroy,]
  include ApplicationHelper

  def index
    @contents = @mcontents
  end
  
  def showcontent
  end

  def showseason
  end

  def seasondestroy
    @season.destroy
    redirect_to content_path(@content), notice: "Season was successfully destroyed."
  end

  def episodedestroy
    @episode.destroy
    redirect_to content_path(@content), notice: "Episode was successfully destroyed."
  end

  private

  def set_content 
    @content = @mcontents.find(params[:content_id])
  end

  def set_season
    @season = @content.seasons.find(params[:season_id])
  end

  def set_episode
    @episode = @season.episodes.find(params[:episode_id])
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
