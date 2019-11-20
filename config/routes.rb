Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  resources :trips, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:create]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
