# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get "home/index"

  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:new, :create]

  root to: "home#index"
end
