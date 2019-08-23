# frozen_string_literal: true

class AppliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @apply = Apply.new(project_id: params[:project], user_id: current_user.id)
    if @apply.save
      redirect_to "/projects/#{params[:project]}", notice: 'Apply was successfully created.'
    else
      redirect_to "/projects/#{params[:project]}", notice: 'We have a problem.'
    end
  end

  def destroy
    binding.pry
    @apply.destroy
  end
end
