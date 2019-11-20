class EmailNotification < ApplicationMailer
    default from: 'noreply@laba42.com'

  def apply_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Вы получили отклик на размещенный проект.')
  end
end
