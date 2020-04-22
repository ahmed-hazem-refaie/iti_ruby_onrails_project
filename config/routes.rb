Rails.application.routes.draw do
  root :to => "home#home"
  resources :notifications
  resources :friendships
  resources :orderdetails
  resources :groups
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :activites
  resources :orders

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
