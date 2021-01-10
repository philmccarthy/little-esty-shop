Rails.application.routes.draw do
  match "/404", to: "errors#not_found", via: :all

  resources :repos
  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :merchants_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants do
    resources :items
    resources :items_status, controller: "merchant_items_status", only: [:update]
    resources :invoices
    resources :invoice_items, only: [:update]
    resources :dashboard, only: [:index]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
end
