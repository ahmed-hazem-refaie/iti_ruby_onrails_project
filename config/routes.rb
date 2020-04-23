Rails.application.routes.draw do
  
  devise_for :users, :paths => 'users'
  
  resources :activites
  resources :notifications
  resources :friendships

  # resource  :users do
    resources :groups
  # end
  resources :orders do
    resources :orderdetails
  end
  
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
