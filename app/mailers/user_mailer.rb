class UserMailer < ApplicationMailer

  default from: 'ranjeev.kumar@wwindia.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Twitter app')
  end
end
