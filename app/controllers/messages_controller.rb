# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
