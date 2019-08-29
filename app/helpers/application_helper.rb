# frozen_string_literal: true

module ApplicationHelper
  def show_devise_link?
    !controller_name.in?(%w[sessions registrations passwords edit_role]) &&
      !request.path.include?('edit_role')
  end
end
