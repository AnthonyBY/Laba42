# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @projects = Project.limit(9).order(created_at: :desc)
  end

  def my_projects
    @projects = current_user.projects if current_user
  end
end
