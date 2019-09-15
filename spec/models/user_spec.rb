# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'should not valid with' do
    before(:each) do
      @user = User.create(email: 'midda999@mail.ru', name: 'Anton', password: '123456', confirmed_at: Time.now.utc)
    end

    it 'wrong mail' do
      @user.email = 'midda'
      expect(@user.valid?).to eq(false)
      expect(@user.errors.messages[:email].first).to eq('имеет неверное значение')
    end

    it 'empty name' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
      expect(@user.errors.messages[:name].first).to eq('не может быть пустым')
    end

    it 'empty password' do
      @user.password = ''
      expect(@user.valid?).to eq(false)
      expect(@user.errors.messages[:password].first).to eq('не может быть пустым')
    end
  end

  context 'can' do
    before(:each) do
      @user = User.new(email: 'midda999@mail.ru', name: 'Anton', password: '123456')
    end

    it 'have skills' do
      expect { @user.skills = '' }.to raise_error(RuntimeError)
      @user.skills = %w[1 2]
      expect(@user.skills).to eq(%w[1 2])
    end
  end

  context 'valid' do
    it 'with right fields' do
      user = User.new(email: 'midda999@mail.ru', name: 'Anton', password: '123456')
      expect(user.valid?).to be_truthy
    end
  end
end
