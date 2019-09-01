# frozen_string_literal: true

class UsersController < ApplicationController
  authorize_resource except: %i[email_exists]
  load_resource

  def index; end

  def email_exists
    render json: { exists: User.exists?(email: params[:email]) }
  end
end
