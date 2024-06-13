class UserMailer < ApplicationMailer

  def send_otp(otp, email)
    @otp = otp
    @admin_email = email
    mail(to: "ashaktawat43@gmail.com", subject: 'Otp for sighin')
  end


  def send_content(user)
    @user = user
    mail(to: user.email, subject: "Your Subscription is going to end")
  end
end
