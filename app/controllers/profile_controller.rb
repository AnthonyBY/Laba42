# frozen_string_literal: true

class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit_role; end

  def customer_setup_info; end

  def developer_setup_info
    @all_skills = {
      ruby: 'Ruby', java: 'Java', kotlin: 'Kotlin', swift: 'Swift', go: 'Go', php: 'PHP',
      cplusplus: 'C++', c: 'C', python: 'Python', javascript: 'JavaScript', csharp: 'C#',
      rust: 'Rust', html: 'HTML', css: 'CSS', sql: 'SQL', visualbasic: 'Visual Basic',
      dotnet: '.NET', objectivec: 'Objective-C'
    }
  end

  def update_role
    raise 'Role already set!' if @user.role

    role = params[:role].to_sym
    raise "Unknown role: #{role}" unless User::USER_ROLES.key?(role)

    redirect_to "/profile/#{params[:role]}_setup_info" if @user.update(role: role)
  end

  def edit; end

  def customer_edit; end

  def developer_edit; end

  def update
    if @user.update(profile_params)
      redirect_to cabinet_profile_path
    else
      session[:field_errors] = true
      redirect_back(fallback_location: customer_edit)
    end
  end

  def cabinet
    if @user.developer?
      @projects = Project.all
      render 'profile/developer_cabinet'
    else
      render 'profile/customer_cabinet'
    end
  end

  protected

  def profile_params
    params.permit([:info, :name, :phone_number, :company_name, skills: []])
  end

  def set_user
    @user = current_user
  end
end
