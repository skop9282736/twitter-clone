Rails.application.routes.draw do
  root 'tweets#index'
  resources :tweets, only: [ :new, :create, :index, :show, :destroy ]
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'my_tweets', to: 'tweets#my_tweets'
  post '', to: 'tweets#like_tweet', as: 'likes'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
