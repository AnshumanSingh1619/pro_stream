class ApplicationController < ActionController::Base
  include ActionController::Cookies
  private
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      semi_users_path
    elsif resource.is_a?(Admin)
      contents_url
    else
      super
    end
  end
end
