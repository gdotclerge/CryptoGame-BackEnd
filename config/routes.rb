Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :portfolios, only: [:show, :create, :update, :destroy]
      resources :tickers, only: [:index, :show]
      resources :users, only: [:show, :create, :update, :destroy]

      post '/login', to: 'auth#login'
    end
  end
end
