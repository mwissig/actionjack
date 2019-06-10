Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
  get 'register' => 'users#new'
  get '/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'
  get 'users/index'
  get 'users/edit'
  get 'users/show'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
 delete 'delete' => 'users#destroy'
 member do
  get :confirm_email
end
end

  resources :password_resets,     only: [:new, :create, :edit, :update]
end
