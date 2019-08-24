# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @projects = Project.limit(9).order(created_at: :desc)
  end
end
