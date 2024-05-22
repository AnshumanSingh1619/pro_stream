# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource && resource.otp != "0"
      otp = rand(111111..999999)
      resource.update_attribute(:otp, otp)
      DestroyAdminOtpJob.perform_in(5.minutes, resource.id)
      UserMailer.send_otp(otp, resource.email).deliver_now
      sign_out(resource)
      redirect_to otp_verification_path(admin_id: resource.id), notice: 'Please verify your OTP sent to the super admin email to complete the registration.'
    else
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
