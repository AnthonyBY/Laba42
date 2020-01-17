# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  after_action :mark_as_read, only: %i[show]

  def index
    @autors = Message
              .includes(:user)
              .where(recipient_id: current_user.id)
              .order(read_status: :asc, created_at: :desc).map(&:user).uniq
  end

  def show
    @messages = Message
                .includes(:user)
                .where('user_id = ? AND recipient_id = ?', params[:id], current_user.id)
                .or(Message.includes(:user)
                    .where('user_id = ? AND recipient_id = ?', current_user.id, params[:id]))
  end

  def create
    @message = Message.new(body_message: messages_params[:body_message],
                           user_id: current_user.id,
                           recipient_id: messages_params[:recipient_id])
    if @message.save
      redirect_to message_path(params[:recipient_id])
    else
      render 'messages/show', alert: @message.errors.full_messages
    end
  end

  private

  def messages_params
    params.permit(:recipient_id).merge(params.require(:message).permit(:body_message))
  end

  def mark_as_read
    Message.where(recipient_id: current_user.id, read_status: 'unread', user_id: params[:id]).update_all(read_status: 'read')
  end
end
