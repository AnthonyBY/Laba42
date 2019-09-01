# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_resource except: %i[create]
  authorize_resource

  def index; end

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(comment_params.merge(user_id: current_user.id, comment_owner_id: params[:project_id]))
    if @comment.save
      redirect_to project_path(@project)
    else
      redirect_to project_path(@project), alert: @comment.errors.full_messages
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_path(@comment.comment_owner.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
