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
    member do
      :measurement_types
    end
  end

  root 'dashboard#index'

end
