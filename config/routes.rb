Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'profiles/new'
  get 'profiles/edit'
  get 'profiles/index'
  get 'profiles/show'
  get 'blackjack/new'
  get 'blackjack/edit'
  get 'blackjack/index'
  get 'blackjack/show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
  get 'register' => 'users#new'
  get '/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lobbychats do
  end
  resources :users do

 delete 'delete' => 'users#destroy'
 member do
  get :confirm_email

end
end
  resources :password_resets,     only: [:new, :create, :edit, :update]
mount ActionCable.server, at: '/cable'
end
