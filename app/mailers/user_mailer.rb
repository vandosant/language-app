class UserMailer < ActionMailer::Base
  default from: 'info@langua.herokuapp.com'

  def new_registration(user)
    mail(
      to: user.email,
      subject: 'Welcome to Langua',
    )
  end
end