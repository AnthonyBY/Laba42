# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: :index
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  get '/uniqness/:email', to: 'uniqness#email_uniqness', constraints: { email: /.+\..+/}

  resources :projects
  resource :profile, controller: 'profile', only: %i[edit update] do
    post 'update_role'
    get 'edit_role'
    get 'customer_setup_info'
    get 'developer_setup_info'
  end
end
