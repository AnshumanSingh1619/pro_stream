class SemiUsersController < ApplicationController
  before_action :authenticate
  before_action :set_semi_user, only: %i[ show edit update destroy ]
  include SemiUsersHelper

  def index
    @semi_users = SemiUser.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @semi_user = SemiUser.new
  end

  def edit
  end

  def create
    @semi_user = SemiUser.new(semi_user_params)
    @semi_user.user_id = current_user.id
    respond_to do |format|
      if @semi_user.save
        format.html { redirect_to semi_users_path, notice: "Semi user was successfully updated." }
        format.json { render :show, status: :created }
      else
        format.html { redirect_to semi_users_path, alert: @semi_user.errors.full_messages.join(", ") }
        format.json { render json: @semi_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @semi_user.update(semi_user_params)
        format.html { redirect_to semi_users_path, notice: "Semi user was successfully updated." }
        format.json { render :show, status: :ok, location: @semi_user }
      else
        format.html { redirect_to semi_users_path, alert: @semi_user.errors.full_messages.join(", ") }
        format.json { render json: @semi_user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy 
    @semi_user.destroy!
    respond_to do |format|
      format.html { redirect_to semi_users_path, notice: "Semi user was successfully destroy." }
      format.json { head :no_content }
    end
  end

  private
    def set_semi_user
      @semi_user = SemiUser.find(params[:id])
      if @semi_user.user_id == current_user.id
      else
        redirect_to semi_users_path
      end
    end

    def semi_user_params
      params.require(:semi_user).permit(:name, :age, :user_id, :profile_pic, :date_of_birth)
    end

    def authenticate 
      if admin_signed_in? 
        redirect_to root_path
      elsif user_signed_in?
        user_authenticate()
      else
        redirect_to new_user_session_path 
      end 
    end
end
