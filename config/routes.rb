Rails.application.routes.draw do
  resources :notifications
  resources :friendships
  resources :orderdetails
  resources :groups
  resources :activites
  devise_for :users#, :controllers => { :omniauth_callbacks => “users/omniauth_callbacks” }
  resources :orders

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
