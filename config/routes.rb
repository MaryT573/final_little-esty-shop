Rails.application.routes.draw do

  get '/', to: "welcome#index"
  get "/merchants/:id/dashboard", to: "merchants#show"

  resources :merchants, except: [:show] do
    resources :items, only: [:index, :show, :edit, :update, :new]
    resources :invoices, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show, :new, :create, :edit, :update]
  end

  post '/merchants/:id/items', to: 'items#create'
  get '/admin', to: 'admins#index'

  # get '/admin/merchants/new', to: 'admin_merchants#new'
  # post '/admin/merchants', to: 'admin_merchants#create'

  # get '/admin/merchants/:id/edit', to: 'admin_merchants#edit'
  # patch '/admin/merchants/:id', to: 'admin_merchants#update'

  #get '/admin/merchants', to: 'admin_merchants#index'
  #patch '/admin/merchants', to: 'admin_merchants#index'

  # get '/admin/merchants/:id', to: 'admin_merchants#show'

    # <%= button_to "Disable #{merchant.name}", "/admin/merchants?disable=#{params[:disable]}", method: :patch, local: true, params: {id: merchant.id}%> </p>

end
