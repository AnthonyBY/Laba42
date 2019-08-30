# frozen_string_literal: true

module ApplicationHelper
  def show_devise_link?
    return false if controller_name.in?(%w[sessions registrations passwords])

    return false if action_name == 'edit_role'

    true
  end
end
