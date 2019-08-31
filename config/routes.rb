# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: :index do
    collection do
      post 'email_exists'
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  resources :projects
  resources :comments
  resources :applies
  resource :profile, controller: 'profile', only: %i[edit update] do
    post 'update_role'
    get 'edit_role'
    get 'customer_setup_info'
    get 'developer_setup_info'
    get 'customer_edit'
    get 'developer_edit'
    get 'cabinet'
  end
end
