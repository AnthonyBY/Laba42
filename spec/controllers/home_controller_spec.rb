# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'not get' do
    it 'index' do
      get :index
      expect(response).to render_template('index')
      # ------code below for future check project------
      # user = User.create(email: 'midda@dsads.re', password: 'verysecret', name: 'Anton')
      # project = Project.create(title: 'Project Index', info: 'New index project', user: user)
      # expect(assigns(:project)).to include(project)
      # -----------------------------------------------
    end
  end
end
