Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :registrations }
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  resources :trips, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:create]
  resources :reviews, only: [:new, :create]
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
