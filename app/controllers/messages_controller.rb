# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @autors = Message
              .includes(:user)
              .where(recipient_id: current_user.id).map(&:user).uniq
  end

  def show
    @messages = Message
                .includes(:user)
                .where('user_id = ? AND recipient_id = ?', params[:id], current_user.id)
                .or(Message.includes(:user)
                    .where('user_id = ? AND recipient_id = ?', current_user.id, params[:id]))
  end

  def create; end

  private

  def messages_params
    params.require(:message).permit(:id)
  end
end
