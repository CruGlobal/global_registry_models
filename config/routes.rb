Rails.application.routes.draw do
  resources :systems, except: :delete do
    post '/reset_token', on: :collection, action: 'reset_token'
  end
  namespace :access_tokens do
    get '/edit', action: 'edit'
    post '/', action: 'update'
  end
  resources :subscriptions, only: [:index, :create, :new, :destroy]
  resources :export_csvs, only: :create

  get 'dashboard/index'

  resource :session, only: [:new, :create, :destroy]

  resources :users, except: :show

  namespace :entities do
    get ':entity_class_name' => 'entities#index'
    get ':entity_class_name/show/:id' => 'entities#show', as: :show
  end

  resources :entity_types do
    post '/:id', on: :collection, action: 'update'
    member do
      get :measurement_types
    end
  end

  resources :relationship_types, only: :create do
    post '/:id', on: :collection, action: 'update'
  end

  resources :measurement_types, only: :create do
    post '/:id', on: :collection, action: 'update'
  end

  root 'dashboard#index'
end
