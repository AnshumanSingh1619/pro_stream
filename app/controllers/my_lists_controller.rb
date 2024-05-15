class MyListsController < ApplicationController
  before_action :authenticate
  before_action :set_content, only: [:create, :destroy]

  def index
    my_list = MyList.where(semi_user_id: session[:current_semi_user_id]["value"])
    my_lists = my_list.order(id: :desc)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results', partial: "shared/mylist", locals: { my_lists: my_lists })
      end
      format.html {}
    end 
  end  
  
  def create 
    mylist = MyList.new(
      content_id: @content.id,
      semi_user_id: session[:current_semi_user_id]["value"],
    )
    if mylist.save
      if @content.seasons.present?
        season = @content.seasons.find_by(season_no: 1)
        redirect_to showseason_path(@content.id, season.id)
      else
        redirect_to showcontent_path(@content.id)
      end 
    end
  end

  def destroy 
    mylist = MyList.find_by(content_id: @content.id, semi_user_id: session[:current_semi_user_id]["value"])
    if mylist.destroy
      if @content.seasons.present?
        season = @content.seasons.find_by(season_no: 1)
        redirect_to showseason_path(@content.id, season.id)
      else
        redirect_to showcontent_path(@content.id)
      end 
    end
  end

  private

  def set_content
    @content = Content.find(params[:content_id])
  end

  def authenticate 
    if admin_signed_in? 
      redirect_to root_path
    elsif user_signed_in?
      unless session[:current_semi_user_id].present?
        redirect_to semi_users_path
      end
    else
      redirect_to new_user_session_path 
    end 
  end
end
