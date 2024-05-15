class IndexController < ApplicationController
  before_action :authenticate
  include ApplicationHelper

  def showmovie
    contents = @mcontents.where(movie_type: "Movie")
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results', partial: "shared/index", locals: { contents: contents })
      end
      format.html {}
    end    
  end

  def showwebseries
    contents = @mcontents.where(movie_type: "Webseries")
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results', partial: "shared/index", locals: { contents: contents })
      end
      format.html {}
    end    
  end

  def searchindex
    parameter = params[:search_term]
    if parameter.present?
      contents = @mcontents.where("name ILIKE ?", "%#{parameter}%")
    else
      contents = []
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results', partial: "shared/categorise", locals: { contents: contents })
      end
      format.html {}
    end    
  end
  
  def categorised
    parameter = params[:search_term2]
    column_name = params[:column_name]
    contents = @mcontents.where("ARRAY[?]::varchar[] <@ #{column_name} AND ? ILIKE ANY (#{column_name}::varchar[])", parameter, parameter)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results', partial: "shared/categorise", locals: { contents: contents })
      end
      format.html {}
    end  
  end
  

  private

  def authenticate 
    if admin_signed_in? 
      @mcontents = Content.all
    elsif user_signed_in?
      user_authenticate()
    else
      redirect_to new_user_session_path 
    end 
  end
end
