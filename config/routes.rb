Rails.application.routes.draw do
  root to: 'announces#index'
  
  devise_for :users

  resources :users do
    resources :announces, shallow: true do
      resources :orders, only: %i[show new create], shallow: true
    end
  end
end
