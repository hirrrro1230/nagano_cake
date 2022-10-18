Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  
  root "public/homes#top"
  
  scope module: :public do
    resources :items, only: [:index, :show] 
  end
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end
  
  post "admin/items/new" =>'admin/items#new'
  patch 'admin/items/:id' => 'admin/items#update', as: "admin/update_item"
  
  resources :homes, only: [:top, :about]
  namespace :admin do
    resources :homes, only: [:top]
  end
  
  get 'about' => 'public/homes#about'
  
  scope module: :public do
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  scope module: :public do
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  end
  
  scope module: :public do
    resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
  end
  post 'orders/new' => 'public/orders#new'
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
