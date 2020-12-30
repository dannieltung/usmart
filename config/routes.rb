Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :categories
  resources :credit_cards
  resources :payments
end
