Rails.application.routes.draw do

  resources :export_csvs, only: [:create]

  get 'dashboard/index'

  resource :session, only: [:new, :create]

  resources :users, except: :show

  namespace :entities do
    resources :target_areas, only: [:index, :show]
  end

  root 'dashboard#index'

end
