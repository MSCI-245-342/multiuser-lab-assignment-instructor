Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/signup', to: 'users#new'    
  resources :users, except: [:new] 
    
  get    '/login',  to: 'sessions#new'    
  post   '/login',  to: 'sessions#create'    
  get '/logout', to: 'sessions#destroy'     
end
