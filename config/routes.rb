Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/payments_due/:id', to: 'payments#show_due', as: 'payment_due'
  get '/payments_date/:id', to: 'payments#show_date', as: 'payment_date'
  patch '/single_payment/:id', to: 'payments#single_update', as: 'single_update'
  put '/single_payment/:id', to: 'payments#single_update'
  # get '/payments_category/:id', to: 'payments#show_category', as: 'payment_category'
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :credit_cards, only: [:new, :create, :edit, :update, :show, :destroy]
  resources :payments, only: [:create, :update, :show, :destroy, :edit]
  resources :buyers, only: [:new, :create, :edit, :update, :destroy]
end
