Rails.application.routes.draw do





  get 'pages/pic2'
  get 'inbox' => 'notifications#index'

  get 'tictactoes/:id/a1' => 'tictactoes#a1'
  get 'tictactoes/:id/a2' => 'tictactoes#a2'
  get 'tictactoes/:id/a3' => 'tictactoes#a3'
  get 'tictactoes/:id/b1' => 'tictactoes#b1'
  get 'tictactoes/:id/b2' => 'tictactoes#b2'
  get 'tictactoes/:id/b3' => 'tictactoes#b3'
  get 'tictactoes/:id/c1' => 'tictactoes#c1'
  get 'tictactoes/:id/c2' => 'tictactoes#c2'
  get 'tictactoes/:id/c3' => 'tictactoes#c3'
  get '/users' => 'users#index'

  get 'tictactoes/new'
  get 'tictactoes/edit'
  get 'tictactoes/index'
  get 'tictactoes/show'
  get 'shop' => 'pages#shop'
  get 'games' => 'pages#games'
  get 'games/blackjack' => 'pages#blackjack'
  get 'games/slots' => 'pages#slots'
  get 'games/slots2' => 'pages#slots2'
  post 'games/slots2' => 'pages#slots'

  get 'games/pictionary' => 'pages#pictionary'
  post 'games/pictionary/update', to: 'pages#pic2'

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
  resources :gamechats do
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
