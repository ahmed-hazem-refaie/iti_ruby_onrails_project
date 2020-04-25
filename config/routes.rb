Rails.application.routes.draw do
  root :to => "home#home"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :activites
  resources :notifications
  # resources :friendships
  resources :friendships do
    member do
      patch :update_with_name
      put :update_with_name
    end
  end

  # resource  :users do
  # resources :groups
  resources :groups do
    member do
       delete 'remove/:friend_id', :action => 'remove',:as => 'remove'
      end
  end
  # match "groups/:id/remove_from_group/:params" => "groups#remove_from_group"   

    


  # end
  resources :orders do
    resources :orderdetails
  end
  
  
  



end
