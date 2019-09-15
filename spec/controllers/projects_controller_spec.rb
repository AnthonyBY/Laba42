# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ProjectsController, type: :controller do
  before(:each) do
    @user = User.create!(
      name: 'midd',
      email: 'user@example.org',
      password: 'very-secret',
      confirmed_at: Time.now.utc,
      role: :customer
    )
    @project = Project.create(
      title: 'Project1',
      info: 'info to project 1',
      user: @user,
      cost: '12',
      cost_type: 'price',
      project_type: 'project_type',
      deadline: rand(1.month).seconds.from_now,
      skills: 'java ruby'
    )
    sign_in @user
  end

  context 'get' do
    it 'returns a successful response and assigns @projects' do
      get :index
      expect(response).to be_successful
      expect(assigns(:projects)).to eq([@project])
    end

    it 'project find by id' do
      get :show, params: { id: @project.id }
      expect(assigns(:project)).to eq(@project)
    end
  end

  context 'get template' do
    it 'index' do
      get :index
      expect(response).to render_template('index')
    end

    it 'new' do
      get :new
      expect(response).to render_template('new')
    end
  end

  context 'project edit by user' do
    it 'author' do
      get :edit, params: { id: @project.id }
      expect(response).to render_template('edit')
    end

    it 'not author' do
      user2 = User.create(name: 'midd22', email: 'usetrr@example.org', password: 'ver12y-secret', confirmed_at: Time.now.utc, role: 'customer')
      project2 = Project.create(
        title: 'Project12',
        info: 'info to project 12',
        user: user2,
        cost: '12',
        cost_type: 'price',
        project_type: 'project_type',
        deadline: rand(1.month).seconds.from_now,
        skills: 'java ruby'
      )
      expect do
        post :update, params: { id: project2.id, project: { title: 'Get error',
                                                            info: 'body error' } }
      end.to raise_error(CanCan::AccessDenied)
    end
  end

  context 'project #create with' do
    it 'correct params' do
      project_params = {
        title: 'Project12',
        info: 'info to project 1',
        cost: 12,
        cost_type: 'price',
        project_type: 'project_type',
        deadline: rand(1.month).seconds.from_now.to_date,
        user_id: @user.id,
        skills: 'css ruby'
      }
      post :create, params: { project: project_params }
      expect(response).to redirect_to(projects_path)
      expect(Project.exists?(project_params.first(7).to_h)).to be_truthy
    end

    it 'wrong params' do
      expect do
        post :create, params: { project: { title: nil, info: nil } }
      end.not_to change { Project.count }
      expect(response).to render_template('new')
    end
  end

  context 'update project with' do
    it 'correct data' do
      post :update, params: { id: @project.id, project: { title: 'proror' } }
      expect(response).to redirect_to(project_path)
      @project.reload
      expect(@project.title).to eq('proror')
    end

    it 'bad data' do
      post :update, params: { id: @project.id, project: { title: '' } }
      expect(response).to render_template('edit')
      @project.reload
      expect(@project.title).to eq('Project1')
    end
  end

  context 'destroy' do
    it 'project' do
      post :destroy, params: { id: @project.id }
      expect(response).to redirect_to(projects_path)
      expect(Project.find_by_id(@project.id)).to be_nil
    end
  end
end
