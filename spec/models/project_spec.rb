# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'Project can' do
    it 'not create without user' do
      project = Project.new(title: 'Best title', info: 'Best info')
      expect(project.valid?).to eq(false)
      expect(project.errors.messages[:user]).to include('не может отсутствовать')
    end
    it 'create with user' do
      user = User.create!(
        name: 'midd22',
        email: 'user@example.org',
        password: 'very-secret',
        role: :customer
      )
      project = Project.create(
        title: 'Project1',
        info: 'info to project 1',
        user: user,
        cost: '12',
        cost_type: 'price',
        project_type: 'project_type',
        deadline: '2020-06-06',
        skills: 'java ruby'
      )
      expect(project.valid?).to eq(true)
    end
  end
end
