class HomeController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token, only: [:update_episode_time]
  before_action :set_content, only: [:showcontent, :showseason, :seasondestroy, :episodedestroy, :update_episode_time]
  before_action :set_season, only: [:showseason, :seasondestroy, :episodedestroy, :update_episode_time]
  before_action :set_episode, only: [:episodedestroy, :update_episode_time]
  include ApplicationHelper

  def index
    @contents = @mcontents
  end
  
  def showcontent
    @content.inc(trailer_view_count: 1)
    @content.save
  end

  def showseason
    @content.inc(trailer_view_count: 1)
    @content.save
  end

  def update_episode_time
    stop_videos = StopVideo.find(params[:stop_video_id])
    stop_videos.update(
      stoppable: @episode,
      semi_user_id: session[:current_semi_user_id]["value"],
      stop_video: params[:currentTime]
    )
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
