Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'  
  root 'oauth#index'

  get 'categories/english' => 'categories#english'
  get 'categories/japanese' => 'categories#japanese'
  get '/mypage' => 'users#mypage'
  get 'oauth/guidance' => 'oauth#guidance'

  resources :categories

  resources :favorites
  resources :blogs do
    collection do      
      post :sort
      get :search
    end
  end

  resources :blogs do
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :favorites, only: [:create , :destroy]
  end

  devise_for :users, controllers: {
  registrations: "users/registrations",
  sessions: "users/sessions",
  omniauth_callbacks: "users/omniauth_callbacks"
}

  devise_scope :user do
    post 'users/sign_in/guest', to: 'users/sessions#guest_sign_in'
    post 'users/sign_in/admin_guest', to: 'users/sessions#admin_guest_sign_in'
  end

  resources :users, only: [:show] 
 
end
