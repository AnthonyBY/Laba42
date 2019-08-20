# frozen_string_literal: true

module ApplicationHelper
  def show_devise_link?
    %w[sessions registrations passwords].none? { |n| n == controller_name }
  end
end
