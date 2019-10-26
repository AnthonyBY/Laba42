# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[email_exists]
  authorize_resource except: %i[email_exists]
  load_resource

  def index
    @users = User.developer
  end

  def email_exists
    render json: { exists: User.exists?(email: params[:email]) }
  end
end
