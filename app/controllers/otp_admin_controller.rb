class OtpAdminController < ApplicationController
  def otp_verification
    @admin = Admin.find(params[:admin_id])
  end

  def otp_verified
    user_provided_otp = params[:otp]
    admin = Admin.find_by(id: params[:admin_id])
    if admin.otp == "11"
      redirect_to otp_verification_path(admin_id: admin.id), alert: 'Your OTP has expired.'
    else
      if admin && admin.otp == user_provided_otp
        admin.update(otp: 0)
        sign_in(admin)
        redirect_to root_path, notice: 'OTP verified successfully. You are now signed in.'
      else
        redirect_to otp_verification_path(admin_id: admin.id), alert: 'Invalid OTP. Please try again.'
      end
    end
  end
  

  def resend_otp
    admin = Admin.find(params[:admin_id])
    otp = rand(111111..999999)
    admin.update_attribute(:otp, otp)
    DestroyAdminOtpJob.perform_in(1.minute, admin.id)
    UserMailer.send_otp(otp, admin.email).deliver_now
    redirect_to otp_verification_path(admin_id: admin.id), notice: 'OTP sent to super admin email'
  end  
end
