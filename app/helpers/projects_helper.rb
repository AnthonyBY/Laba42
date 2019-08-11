# frozen_string_literal: true

module ProjectsHelper
  def user_is_owner?
    @project.user_id == current_user.id
  end
end
