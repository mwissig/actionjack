Rails.application.routes.draw do

  get 'tictactoe/a1'
  get 'tictactoe/a2'
  get 'tictactoe/a3'
  get 'tictactoe/b1'
  get 'tictactoe/b2'
  get 'tictactoe/b3'
  get 'tictactoe/c1'
  get 'tictactoe/c2'
  get 'tictactoe/c3'

  get 'tictactoe/new'
  get 'tictactoe/edit'
  get 'tictactoe/index'
  get 'tictactoe/show'
  get 'shop' => 'pages#shop'
  get 'games' => 'pages#games'
  get 'games/blackjack' => 'pages#blackjack'
  get 'games/slots' => 'pages#slots'
  get 'games/slots2' => 'pages#slots2'
  post 'games/slots2' => 'pages#slots'
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
  resources :tictactoes do
  end
  resources :users do
      resources :profiles do

      end

 delete 'delete' => 'users#destroy'
 member do
  get :confirm_email

end
end
  resources :password_resets,     only: [:new, :create, :edit, :update]
mount ActionCable.server, at: '/cable'
end
