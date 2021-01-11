Rails.application.routes.draw do
  devise_for :customers
  root to: "welcome#index"
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  devise_for :admins, controllers: {:sessions => "admins/sessions", :passwords => "admins/passwords", :registrations => "admins/registrations"}
  namespace :admin do
    resources :merchants, except: [:destoy]
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
