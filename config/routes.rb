Rails.application.routes.draw do
  root 'oauth#index'
  resources :blogs
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
end
