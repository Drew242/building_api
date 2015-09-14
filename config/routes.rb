Rails.application.routes.draw do
  root 'items#index'

  resources :items
  resources :users
  resources :orders

  namespace :api do
    namespace :v1 do
      resources :items, except [:new, :edit]
    end
  end
end
