class UserMailer < ApplicationMailer

  def registration()
    email = "ashaktawat43@gmail.com"
    mail(to: email, subject: 'Welcome mail')
  end

end
