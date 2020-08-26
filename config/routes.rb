Rails.application.routes.draw do
  devise_for :users

  resources :announces
  # root to: 'announces#index'

  root to: 'pages#home'

end
