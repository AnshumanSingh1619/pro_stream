# frozen_string_literal: true

class Admins::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
  
    if resource.save
      expire_data_after_sign_in!
  
      otp = rand(111111..999999)
      resource.update_attribute(:otp, otp)
  
      UserMailer.send_otp(otp, resource.email).deliver_now
      DestroyAdminOtpJob.perform_in(1.minute, resource.id)
      redirect_to otp_verification_path(admin_id: resource.id), notice: 'Please verify your OTP sent to super admin email to complete the registration.'
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    super
    redirect_to admin_registration_path
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :gender, :age, :date_of_birth, :otp])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :gender, :age, :date_of_birth, :otp])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    otp_verification_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    otp_verification_path
  end
end
