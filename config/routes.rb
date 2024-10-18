require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api, constraints: ->(req) { %w[json].include? req.format } do
    namespace :v1 do
      resources :companies, only: %i[index create show] do
        collection do
          get 'search'
        end
      end

      resources :users, only: %i[create index destroy] do
        member do
          get 'peers'
        end
      end

      namespace :users do
        post 'joins_leader'
        get 'managed_users'
        get 'sub_managed_users'
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
  mount Sidekiq::Web => '/sidekiq'
end
