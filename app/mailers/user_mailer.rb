class UserMailer < ApplicationMailer

  def send_otp(otp, email)
    @otp = otp
    @admin_email = email
    mail(to: "ashaktawat43@gmail.com", subject: 'Otp for sighin')
  end


  def send_content(email)
    mail(to: email, subject: "Your favorite content")
  end
end
