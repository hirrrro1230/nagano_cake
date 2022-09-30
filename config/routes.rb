Rails.application.routes.draw do

  devise_for :admins, controllers: {
    registrations: "admin/sessions"
  }
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
end
