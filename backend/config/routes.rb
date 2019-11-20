Rails.application.routes.draw do
  resources :steps
  resources :routines
  resources :journal_entries
  resources :product_ingredients
  resources :ingredients
  resources :user_products
  resources :products do
    resources :ingredients
  end
  resources :users do
    resources :user_products
  end
  match '/users/:id/ingredients/:ingredient_id' => "ingredients#ingredient_params", :via => :get
  match 'user_products/users/:user_id' => "user_products#user_reviews", :via => :get
  # match '/users/:id/user_products/:product_id' => "users#user_params", :via => :get 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end