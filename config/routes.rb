Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/payments/:id', to: 'payments#show_due', as: 'payment_due'
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :credit_cards, only: [:new, :create, :edit, :update, :destroy]
  resources :payments, only: [:create, :edit, :update, :show, :destroy]
  resources :buyers, only: [:new, :create, :edit, :update, :destroy]
end
