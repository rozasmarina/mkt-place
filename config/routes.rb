Rails.application.routes.draw do
  root to: 'announces#index'
  resources :announces, only: %i[show edit update destroy]
  devise_for :users
  resources :users do
    resources :announces, only: %i[new create]
    resources :orders, only: %i[index new create show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
