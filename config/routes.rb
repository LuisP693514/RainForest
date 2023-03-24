Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create, :show]
    resource :session, only: [:show, :create, :destroy]
    resources :products, only: [:index, :show, :update]
    resources :categories, only: [:index, :show]
    resource :cart, only: [:show]
    resources :cart_items, only: [:index, :update, :create, :destroy]
    resources :reviews, only: [:update, :create, :destroy]
  end

  get '/api/reviews/user/:user_id', to: 'api/reviews#user_reviews_index'
  get '/api/reviews/product/:product_id', to: 'api/reviews#product_reviews_index'
  get '*path', to: "static_pages#frontend_index"

end
