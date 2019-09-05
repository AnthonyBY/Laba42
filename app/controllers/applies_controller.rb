# frozen_string_literal: true

class AppliesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  load_resource except: %i[create]

  def index; end

  def create
    @apply = Apply.new(apply_params.merge(user_id: current_user.id))
    redirect_to "/projects/#{params[:project_id]}" if @apply.save
  end

  def destroy
    @apply.destroy
    redirect_to applies_path
  end

  private

  def apply_params
    params.permit(:project_id)
  end
end
