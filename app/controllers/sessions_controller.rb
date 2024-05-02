class SessionsController < ApplicationController

  def start
    semiuser = SemiUser.find_by(id: params[:semi_user_id])
    if semiuser
      cookies[:current_semi_user_id] = {
        value: semiuser.id,
        expires: 1.month.from_now 
      }
      redirect_to root_path
    else
      redirect_to semi_users_path
    end
  end

  def destroy
    cookies.delete(:current_semi_user_id)
    redirect_to semi_users_path
  end
end
