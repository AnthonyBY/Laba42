# frozen_string_literal: true

class AppliesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  load_resource except: %i[create]

  def index; end

  def create
    @apply = Apply.new(apply_params.merge(user_id: current_user.id))
    if @apply.save
      EmailNotification.with(user: Project.find(params[:project_id]).user).apply_email.deliver_later
      redirect_to "/projects/#{params[:project_id]}"
    else
      redirect_to "/projects/#{params[:project_id]}", alert: 'Что-то пошло не так...'
    end
  end

  def destroy
    @apply.destroy
    redirect_to applies_path
  end

  # rubocop:disable Metrics/AbcSize
  def appointment
    if Project.find(params[:project_id]).update(employee: params[:appointed_user])
      Apply.find(params[:apply_id]).update(apply_status: 'accept')
      EmailNotification.with(user: User.find(params[:appointed_user])).appointment_email.deliver_later
      redirect_to cabinet_profile_path, notice: t(:assigned)
    else
      redirect_to project_applies_path, alert: 'Что-то пошло не так...'
    end
  end
  # rubocop:enable Metrics/AbcSize

  def implementation
    if Project.find(params[:project_id]).status_notification_sent!
      redirect_to cabinet_profile_path, notice: 'Ответ отправлен. Молодец!'
    else
      redirect_to cabinet_profile_path, alert: 'Что-то пошло не так...'
    end
  end

  private

  def apply_params
    params.permit(:project_id)
  end
end
