# frozen_string_literal: true

class EmailNotification < ApplicationMailer
  default from: 'noreply@laba42.com'

  def apply_email
    mail(to: getting_user.email, subject: 'Вы получили отклик на размещенный проект.')
  end

  def appointment_email
    mail(to: getting_user.email, subject: 'Вас утвердили испонителем для проекта')
  end

  def comment_email
    mail(to: getting_user.email, subject: 'Ваш проект прокомментировали.')
  end

  private

  def getting_user
    @user = params[:user]
  end
end
