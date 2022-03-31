Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'oauth#index'
  resources :blogs do
    resources :comments
  end

  devise_for :users, controllers: {
  registrations: "users/registrations",
  sessions: "users/sessions",
  omniauth_callbacks: "users/omniauth_callbacks"
}

  devise_scope :user do
    get "signup", :to => "users/registrations#new" 
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end
end
