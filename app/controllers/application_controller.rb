# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :authenticate_user!, only: %i[select_role edit_user_info]

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def select_role
    set_role if request.post?
  end

  def edit_user_info
    edit_post if request.post?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def set_role
    # use strong assignment, for wrong params
    current_user.role = 0 if params[:role] == 0.to_s
    current_user.role = 1 if params[:role] == 1.to_s
    current_user.save!
    redirect_to '/edit_user_info'
  end

  def edit_post
    # methods from post params been later, after add form page
    # create check for right fields and back to form, when wrong data
    redirect_to '/'
  end
end
