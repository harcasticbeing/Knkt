Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  get '/home', to: 'home#index'
  get '/user/:id', to: 'users#show'
  post '/user', to: 'users#follow'
  delete '/user', to: 'users#unfollow'
  get '/followers', to: 'home#followers'
  get '/followings', to: 'home#followings'
  resources :posts
end
