# frozen_string_literal: true

class AppliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id

  def create
    @apply = Project.find(set_project_id).applies.new(user_id: set_user_id)
    if @apply.save
      redirect_to "/projects/#{set_project_id}", notice: 'Apply was successfully created.'
    else
      redirect_to "/projects/#{set_project_id}", notice: 'We have a problem.'
    end
  end

  def destroy
    @apply.destroy
    respond_to do |format|
      format.html { redirect_to applies_url, notice: 'Apply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_project_id
    params[:project]
  end

  def set_user_id
    current_user.id
  end
end
