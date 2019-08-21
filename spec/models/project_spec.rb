# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'Project can' do
    it 'not create without user' do
      project = Project.new(title: 'Best title', info: 'Best info')
      expect(project.valid?).to eq(false)
      expect(project.errors.messages[:user]).to include('must exist')
    end
    it 'create with user' do
      project = Project.new(title: 'Best title', info: 'Best info', user: User.new)
      expect(project.valid?).to eq(true)
    end
  end
end
