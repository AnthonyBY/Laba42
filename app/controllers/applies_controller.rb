# frozen_string_literal: true

class AppliesController < ApplicationController
  before_action :authenticate_user!

  def index
    @applies = current_user.applies
  end

  def create
    @apply = Apply.new(project_id: params[:project], user_id: current_user.id)
    if @apply.save
      redirect_to applies_path
    else
      redirect_to "/projects/#{params[:project]}", notice: 'We have a problem.'
    end
  end

  def destroy
    @apply = current_user.applies.find(params[:id])
    @apply.destroy
    redirect_to applies_path
  end
end
