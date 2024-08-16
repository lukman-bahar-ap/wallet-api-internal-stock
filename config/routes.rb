Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  namespace :api do
    get 'user/list', to: 'user#list'
    get 'user_login/list', to: 'user_login#list'
    get 'stocks/all', to: 'stocks#all'
    get 'stocks/prices', to: 'stocks#index'
    get 'stocks/show', to: 'stocks#show'

    namespace :transaction do
      post 'deposit', to: 'wallet_transaction#deposit'
      post 'withdraw', to: 'wallet_transaction#withdraw'
      post 'transfer', to: 'wallet_transaction#transfer'
      post 'purchase', to: 'wallet_transaction#purchase'
    end

  end
end
