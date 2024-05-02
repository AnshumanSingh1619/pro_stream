module ApplicationHelper
  def user_authenticate
    if session[:current_semi_user_id].present?
      current_semi_user()
    else
      redirect_to semi_users_path
    end
  end

  def current_semi_user
    @current_semi_user = SemiUser.find(session[:current_semi_user_id]["value"])
    if @current_semi_user.user_id == current_user.id
      if @current_semi_user.age < 18
        @mcontents = Content.where(available_for_kids: "Available for all")
      else
        @mcontents = Content.all
      end
    else
      redirect_to semi_users_path
    end
  end
end
