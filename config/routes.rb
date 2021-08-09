Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  # get 'static_pages/help'
  # GETリクエストが/helpに送信された時にStaticPagesのコントローラーのhelpアクションを呼び出してくれる
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
end
