Rails.application.routes.draw do

  resources :appointments
  resources :products
  resources :work_days

  get "/move_product_to_top" => 'products#move_to_top'
  post '/login' => 'authetication#login'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "root#root"
end
