module SemiUsersHelper
  def user_authenticate
    if current_user.subscription_ends_at > Time.zone.now   
      if current_user.subscription_ends_at > Time.zone.now
        if current_user.plan == "monthly"
          client = DeviceDetector.new(request.user_agent)
          unless current_user.devise_type == "smartphone"
            sign_out current_user
            redirect_to root_url, notice: "Your plan is only avilable for mobile"
          end
        end
      else
        semi_users_path
      end 
      if session[:current_semi_user_id].present?
        session.delete(:current_semi_user_id)
      end   
    else
      redirect_to pricing_path
    end
  end
end
  