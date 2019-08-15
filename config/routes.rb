# frozen_string_literal: true

# rubocop:disable Layout/SpaceInsideHashLiteralBraces
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  resources :projects
end
# rubocop:enable Layout/SpaceInsideHashLiteralBraces
