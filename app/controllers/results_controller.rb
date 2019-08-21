# frozen_string_literal: true

class ResultsController < ApplicationController
  def index
    @search_results = Project.search_by_projects(params[:query])
  end
end
