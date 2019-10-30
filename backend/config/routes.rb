Rails.application.routes.draw do
  resources :steps
  resources :routines
  resources :journal_entries
  resources :product_ingredients
  resources :ingredients
  resources :user_products
  resources :products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
