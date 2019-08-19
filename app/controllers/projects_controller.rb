# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  authorize_resource
  load_resource except: %i[show index]

  def index
    @projects = Project.includes(:user).load
  end

  def show
    @project = Project.includes(:user).find(params[:id])
  end

  def new; end

  def edit; end

  def create
    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :info)
  end
end
