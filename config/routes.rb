Rails.application.routes.draw do
  # get 'password_resets/new'
  # get 'password_resets/edit'
  get 'sessions/new'
  # get 'users/new'
  root 'static_pages#home'
  # get 'static_pages/help'
  # GETリクエストが/helpに送信された時にStaticPagesのコントローラーのhelpアクションを呼び出してくれる
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit] # 今回はeditアクションだけに絞ってる, editアクションはアカウント有効に使える特別なアクション
  resources :password_resets, only: [:new, :create, :edit, :update]
end
