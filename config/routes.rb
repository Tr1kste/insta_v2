# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get "home/index"

  resources :users, only: [:show, :edit, :update]
  resources :posts do
    resources :comments
  end

  root to: "home#index"
end
