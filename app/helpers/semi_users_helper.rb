module SemiUsersHelper
  def user_authenticate
    if session[:current_semi_user_id].present?
      session.delete(:current_semi_user_id)
    end   
  end
end
  