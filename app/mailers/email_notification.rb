# frozen_string_literal: true

# This class smells of :reek:InstanceVariableAssumption
class EmailNotification < ApplicationMailer
  default from: 'noreply@laba42.com'

  def apply_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Вы получили отклик на размещенный проект.')
  end

  def appointment_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Вас утвердили испонителем для проекта')
  end
end
