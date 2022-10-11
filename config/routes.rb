Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    registrations: "admin/sessions"
  }
  
  root "public/homes#top"
  
  resources :items, only: [:index, :show] 
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  
  resources :homes, only: [:top, :about]
  namespace :admin do
    resources :homes, only: [:top]
  end
  
  get 'about' => 'public/homes#about'
  
  resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  
  resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
  namespace :admin do
    resources :orders, only: [:show, :update]
  end
  
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  
  namespace :admin do
    resources :order_details, only: [:update]
  end


  
end
