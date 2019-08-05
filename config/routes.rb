Rails.application.routes.draw do
  root 'pages#home'
  resources :users
  resources :photos
  resources :albums
  resources :categories
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
