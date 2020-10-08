Rails.application.routes.draw do
  root 'pages#home'
  #action '/uri_name', to: 'actions_controller#function'
  get 'about', to: 'pages#about'
  resources :articles#, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  get 'signup', to: 'users#new' #form submits to users#create
  resources :users, except: [:new]
end
