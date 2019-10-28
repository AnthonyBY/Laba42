# frozen_string_literal: true

require 'redcarpet'

module ApplicationHelper
  def show_devise_link?
    return false if controller_name.in?(%w[sessions registrations passwords])

    return false if %w[edit_role customer_setup_info developer_setup_info].include?(action_name)

    true
  end

  def customer_in_profile?
    return false unless current_user

    return true if current_user.customer? && !%w[customer_setup_info developer_setup_info edit_role].include?(action_name)

    :dev if current_user.developer? && !%w[customer_setup_info developer_setup_info edit_role].include?(action_name)
  end

  def white_background?
    'index,new'.include?(action_name) && 'home'.include?(controller_name) ||
        'sessions,registrations,profile'.include?(controller_name) &&
            !'cabinet'.include?(action_name)
  end

  # This method smells of :reek:UtilityFunction
  def markdown(text)
    Markdown.new(text, :hard_wrap, :autolink).to_html.html_safe
  end
end
