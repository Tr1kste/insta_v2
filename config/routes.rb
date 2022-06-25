# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  get "home/index"  

  resources :users, only: %i[show edit update] do
    get "followers", to: 'follows#followers'
    get "followees", to: 'follows#followees'
  end

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  root to: "home#index"
end
