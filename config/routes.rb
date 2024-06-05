require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :admin do 
    mount Sidekiq::Web => "/sidekiq"
  end
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
  resources :semi_users
  root to: "home#index"
  get '/prostream/content/:content_id/', to: 'home#showcontent', as: 'showcontent'
  post '/prostream/season/:content_id/:season_id', to: 'home#showseason', as: 'showseason'
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
  get '/mylist',  to: 'my_lists#index', as: 'mylists' 
  get 'pricing', to: 'stripe/checkout#pricing'
  post 'stripe/checkout', to: 'stripe/checkout#checkout'
  get 'stripe/checkout/success', to: 'stripe/checkout#success'
  get 'stripe/checkout/cancel', to: 'stripe/checkout#cancel'
  post 'stripe/billing_portal', to: 'stripe/billing_portal#create'
  get 'otp_verification', to: 'otp_admin#otp_verification', as: 'otp_verification'
  post 'otp_verification', to: 'otp_admin#otp_verified'
  post '/resend_otp', to: 'otp_admin#resend_otp', as: 'resend_otp'
end



#./stripe listen --forward-to localhost:3000/stripe/webhooks