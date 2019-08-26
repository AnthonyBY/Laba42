# frozen_string_literal: true

class AppliesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
  load_resource except: %i[create]

  def index; end

  def create
    # @apply = Apply.new(project_id: params[:project_id], user_id: current_user.id)
    @apply = Apply.new(apply_params)
    if @apply.save
      redirect_to applies_path
    else
      redirect_to "/projects/#{params[:project_id]}"
    end
  end

  def destroy
    @apply.destroy
    redirect_to applies_path
  end

  private

  def apply_params
    params.permit(:project_id).merge(user_id: current_user.id)
  end
end
