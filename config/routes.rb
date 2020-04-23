Rails.application.routes.draw do
  root :to => "home#home"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :activites
  resources :notifications
  resources :friendships

  # resource  :users do
    resources :groups
  # end
  resources :orders do
    resources :orderdetails
  end
  
  
  



end
