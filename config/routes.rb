Rails.application.routes.draw do

  resources :export_csvs, only: [:create]

  get 'dashboard/index'

  resource :session, only: [:new, :create, :destroy]

  resources :users, except: :show

  namespace :entities do
    get ':entity_class' => 'entities#index'
    get ':entity_class/show/:id' => 'entities#show', as: :show
  end

  root 'dashboard#index'

end
