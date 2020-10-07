Rails.application.routes.draw do

  resources :products
  resources :work_days
  post '/login' => 'authetication#login'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "root#root"
end
