Rails.application.routes.draw do
  root to: 'announces#index'
  
  devise_for :users

  resources :users do
    resources :announces, shallow: true do
      resources :orders, only: %i[show new create], shallow: true do
        resources :payments, only: :new
      end
    end
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # open ou routes to code from somewhere else, like an API (it's not the routes we created ourselves)
  # it's stripe's controllers handling it
end
