# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  get "home/index"

  resources :users, only: [:show, :edit, :update]
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
