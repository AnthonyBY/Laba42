# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :unfilled_rol, only: [:index]

  def index; end

  private

  def unfilled_rol
    if current_user.nil?
    elsif current_user.role.nil?
      redirect_to '/select_role'
    end
  end
end
