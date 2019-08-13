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
        session['devise.google_data'] = request.env['omniauth.auth']
      end
      redirect_to '/'
    end

    def facebook
      if  current_user.present?
          current_user.apply_omniauth(request.env["omniauth.auth"])
          redirect_to edit_user_registration_path, notice: "Facebook Account Linked!"
      else
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
      end
    end

    def apply_omniauth(auth)
      update_attributes(
        provider: auth.provider,
        uid: auth.uid
      )
    end

    def has_facebook_linked?
      self.provider.present? && self.uid.present?
    end
  end
end
