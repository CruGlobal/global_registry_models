Rails.application.routes.draw do

  resources :export_csvs, only: [:create]

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

  resources :relationship_types, only: [:update, :create] do
    post '/:id', on: :collection, action: 'update'
  end

  

  root 'dashboard#index'

end
