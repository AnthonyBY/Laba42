# frozen_string_literal: true

require 'redcarpet'

module ApplicationHelper
  def show_devise_link?
    return false if controller_name.in?(%w[sessions registrations passwords])

    return false if action_name == 'edit_role'

    true
  end

  # This method smells of :reek:UtilityFunction
  def markdown(text)
    Markdown.new(text, :hard_wrap, :autolink).to_html.html_safe
  end
end
