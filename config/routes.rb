Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/portfolios', to: 'portfolios#create'
      resources :portfolios, only: [:show, :update, :destroy]
      resources :tickers, only: [:index, :show]
      resources :users, only: [:show, :create, :update, :destroy]

      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'
    end
  end
end
