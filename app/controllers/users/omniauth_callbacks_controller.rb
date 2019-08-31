# frozen_string_literal: true

# This module smells of :reek:UncommunicativeMethodName
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        flash[:alert] = @user.errors.full_messages
      end
      redirect_to '/'
    end

    def facebook
      if current_user.present?
        flash[:alert] = @user.errors.full_messages
      else
        @user = User.from_omniauth(request.env['omniauth.auth'])
        sign_in_and_redirect @user
      end
    end
  end
end
