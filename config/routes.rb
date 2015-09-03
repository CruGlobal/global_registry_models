Rails.application.routes.draw do

  get 'dashboard/index'

  resource :session, only: [:new, :create]

  resources :users

  root 'dashboard#index'

end
