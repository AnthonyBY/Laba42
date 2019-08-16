# frozen_string_literal: true

module ApplicationHelper
  def hide_devise_link?
    %w[sessions registrations passwords].any? { |n| n == controller_name }
  end
end
