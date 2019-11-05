Rails.application.routes.draw do
  resources :steps
  resources :routines
  resources :journal_entries
  resources :product_ingredients
  resources :ingredients
  resources :user_products
  resources :products
  resources :users
  #   resources :ingredients
  # end
  match '/users/:id/ingredients/:ingredient_id' => "ingredients#ingredient_params", :via => :get 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
