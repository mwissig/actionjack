Rails.application.routes.draw do





  get 'admin' => 'pages#admin'

  get 'checkers/new'
  get 'checkers' => 'checkers#index'
  get 'checkers/edit'
  get 'checkers/show'
  mount Ckeditor::Engine => '/ckeditor'
  get 'friends/new'
  get 'friends/edit'
  get 'friends/index'
  get 'friends/show'
  get 'pages/pic2'
  get 'inbox' => 'notifications#index'


  get '/users' => 'users#index'

  get 'tictactoes/new'
  get 'tictactoes/edit'
  get 'tictactoes/index'
  get 'tictactoes/show'
  get 'tictactoes/:id/play' => 'tictactoes#play'

  get 'shop' => 'pages#shop'
  get 'shop/buy' => 'pages#buy'
    get 'shop/sell' => 'pages#sell'
    get 'feed' => 'pages#feed'
        get 'fill_feeder' => 'pages#fillfeeder'
        get 'dispose' => 'pages#dispose'

  get 'games' => 'pages#games'
  get 'games/blackjack' => 'pages#blackjack'
  get 'games/slots' => 'pages#slots'
  get 'games/slots2' => 'pages#slots2'
  post 'games/slots2' => 'pages#slots'

  get 'games/pictionary' => 'pages#pictionary'
  post 'games/pictionary/update', to: 'pages#pic2'

  get 'mine' => 'pages#mine'
  get 'mine/move'
  post 'mine/move'
  get 'mine/dig'
  post 'mine/dig'
  get 'mine/place'
  post 'mine/place'

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
  resources :slots do
  end
  resources :shopitems do
  end
  resources :lobbychats do
  end
  resources :notifications do
  end
  resources :gamechats do
  end
  resources :tictactoes do
  end
  resources :users do
      resources :profiles do

      end
      resources :items do

      end
      resources :friends do

      end
 delete 'delete' => 'users#destroy'
 member do
  get :confirm_email

end
end
  resources :password_resets,     only: [:new, :create, :edit, :update]
mount ActionCable.server, at: '/cable'

end
