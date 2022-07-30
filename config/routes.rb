# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'populate_carts#index'
  resources :orders, only: %i[index update show create new]
  resources :carts, only: %i[create index]
  resources :inline_items, only: %i[update create destroy]
  resources :items, only: %i[show index create update]
  resources :categories, only: %i[index create]
  resources :populate_carts, only: [:index]
  resources :search, only: [:index]

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
