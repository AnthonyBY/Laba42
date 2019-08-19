# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :handle_unfilled_role

  protected

  def handle_unfilled_role
    redirect_to '/profile/edit_role' if current_user && !current_user.role
  end
end
