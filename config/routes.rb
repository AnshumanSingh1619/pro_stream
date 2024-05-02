Rails.application.routes.draw do
  resources :my_lists
  resources :contents
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }  
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  resources :contents
  resources :semi_users
  root to: "home#index"
  get '/prostream/content/:content_id/', to: 'home#showcontent', as: 'showcontent'
  get '/prostream/season/:content_id/:season_id', to: 'home#showseason', as: 'showseason'
  delete '/prostream/season/:content_id/:season_id', to: 'home#seasondestroy', as: 'deleteseason'
  delete '/prostream/episode/:content_id/:season_id/:episode_id', to: 'home#episodedestroy', as: 'deletepisode'
  get '/movies', to: 'index#showmovie', as: 'show_movie'
  get '/webseries', to: 'index#showwebseries', as: 'show_webseries'
  get 'categorised/:search_term2/:column_name', to: 'index#categorised', as: 'custom_content'
  post '/search', to: 'index#searchindex', as: 'search'
  get 'search/:semi_user_id',   to: 'sessions#start', as: 'session_create'
  delete '/logout',  to: 'sessions#destroy', as: 'session_destroy' 
  post '/prostream/movie/:content_id',  to: 'my_lists#create', as: 'add_to_list' 
  delete '/prostream/movie/:content_id',  to: 'my_lists#destroy', as: 'remove_from_list' 
  get '/mylist',  to: 'my_lists#index', as: 'mylist' 
end
