Rails.application.routes.draw do

  get '/', to: "welcome#index"
  get "/merchants/:id/dashboard", to: "merchants#show"

  post '/merchants/:id/items', to: 'items#create'

  get '/admin', to: 'admin#index'

  get '/admin/merchants', to: 'admin/merchants#index'
  patch '/admin/merchants', to: 'admin/merchants#index'

  resources :merchants, except: [:show] do
    resources :items, only: [:index, :show, :edit, :update, :new]
    resources :invoices, only: [:index, :show, :update]
    resources :bulkdiscounts, only: [:index, :show, :new, :create, :destroy]
  end

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:show, :new, :create, :edit, :update]
  end
end
