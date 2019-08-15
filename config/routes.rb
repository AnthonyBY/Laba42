# frozen_string_literal: true

# rubocop:disable Layout/SpaceInsideHashLiteralBraces
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'home#index'

  resources :projects
  match '/select_role', to: 'application#select_role', via: :all
  match '/edit', to: 'application#edit', via: :all
end
# rubocop:enable Layout/SpaceInsideHashLiteralBraces
