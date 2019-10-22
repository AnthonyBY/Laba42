# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @projects = Project.limit(9).order(created_at: :desc)
    redirect_to projects_path if current_user && current_user.developer?
  end

  def my_projects
    @projects = current_user.projects if current_user
  end
end
