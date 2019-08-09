# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'home#index'
  resources :authentications, only: [:destroy]
  match '/auth/facebook/callback' => 'services#create'
end
