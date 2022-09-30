Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admins, skip: [:registrations, :passwords] , controllers: {
    registrations: "admin/sessions"
  }
  
end
