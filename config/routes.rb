Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :activites
  resources :notifications
  resources :friendships
  resources :groups do
    member do
       delete 'remove/:friend_id', :action => 'remove',:as => 'remove'
       post 'add_friend', :action => 'add_friend'
      end
  end
  resources :orders do
    resources :orderdetails
    member do
      post 'invited' 
      post 'joined'
      post 'finish'
    end
    
  end
  
  
  
  



end
