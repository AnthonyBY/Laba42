# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @projects = Project.last(9).reverse
  end
end
