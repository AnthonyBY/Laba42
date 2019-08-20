# frozen_string_literal: true

class ProfileController < ApplicationController
  skip_before_action :handle_unfilled_role, only: %i[edit_role update_role]
  before_action :authenticate_user!
  before_action :set_user

  def edit_role; end

  def customer_setup_info; end

  def update_role
    raise 'Role already set!' unless @user.role

    role = params[:role].to_sym
    raise "Unknown role: #{role}" unless User::USER_ROLES.key?(role)

    @user.update(role: role)
    redirect_to '/profile/customer_setup_info'
  end

  def edit; end

  def update
    if @user.update(profile_params)
      redirect_to '/'
    else
      render 'profile/customer_setup_info'
    end
  end

  protected

  def profile_params
    params.permit(%i[info name])
  end

  def set_user
    @user = current_user
  end
end
