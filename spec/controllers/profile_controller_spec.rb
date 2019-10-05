# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  before(:each) do
    @request.host = '127.0.0.1:3000'
    @user = User.create!(name: 'midd', email: 'user@example.org', password: 'very-secret', confirmed_at: Time.now.utc)
    sign_in @user
  end

  it 'Correct template response edit role' do
    get :edit_role
    expect(response).to render_template('edit_role')
  end

  context 'Testing customer' do
    before(:each) do
      @user.update(role: :customer)
    end

    it 'customer setup info' do
      get :customer_setup_info
      expect(response).to render_template('customer_setup_info')
    end

    it 'edit' do
      get :edit
      expect(response).to render_template('edit')
    end
  end

  context 'Testing developer' do
    it 'update' do
      @user.update(role: :developer)
      post 'update', params: { phone_number: '3423432', company_name: 'company_name user' }
      expect(response).to redirect_to(cabinet_profile_path)
      @user.reload
      expect(@user.phone_number).to eq('3423432')
      expect(@user.company_name).to eq('company_name user')
    end

    it 'update role' do
      post 'update_role', params: { role: :developer }
      expect(response).to redirect_to(developer_setup_info_profile_path)
      @user.reload
      expect(@user.role).to eq('developer')
    end
  end
end
