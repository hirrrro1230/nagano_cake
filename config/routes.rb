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
  
  scope module: :public do
    resources :homes, only: [:top, :about]
  end
  namespace :admin do
    resources :homes, only: [:top]
  end
  
  get 'about' => 'public/homes#about'
  get 'admin' => 'admin/homes#top'
  
  scope module: :public do
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  
  scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
  end
  
  scope module: :public do
    resources :orders, only: [:new, :confirm, :complete, :create, :index, :show]
  end
  post 'orders/new' => 'public/orders#new'
  get 'orders/confirm' => 'public/order#confirm'
  post 'orders/confirm' => 'public/order#confirm'
  namespace :admin do
    resources :orders, only: [:show, :update]
  end
  
  scope module: :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  
  namespace :admin do
    resources :order_details, only: [:update]
  end


  
end
