# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_as_read, only: %i[show]

  def index
    inbox = Message
            .includes(:user)
            .where(recipient_id: current_user.id)
            .order(read_status: :asc, created_at: :desc)
    @autors = inbox.map(&:user).uniq
    @unread_user_id_arr = inbox.read_status_unread.map(&:user_id).uniq
  end

  def show
    @messages = Message
                .includes(:user)
                .where('user_id = ? AND recipient_id = ?', params[:id], current_user.id)
                .or(Message.includes(:user)
                    .where('user_id = ? AND recipient_id = ?', current_user.id, params[:id]))
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @message = Message.new(body_message: messages_params[:body_message],
                           user_id: current_user.id,
                           recipient_id: messages_params[:recipient_id])
    if @message.save
      EmailNotification.with(user: User.find(params[:recipient_id])).message_email.deliver_later
      redirect_to message_path(params[:recipient_id])
    else
      render 'messages/show', alert: @message.errors.full_messages
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def messages_params
    params.permit(:recipient_id).merge(params.require(:message).permit(:body_message))
  end

  def mark_as_read
    Message.where(recipient_id: current_user.id, read_status: 'unread', user_id: params[:id]).update_all(read_status: 'read')
  end
end
