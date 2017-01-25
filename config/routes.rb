Rails.application.routes.draw do
  get 'recommendations/index'

  resources :recommendations, only: %i[index create show]
  resources :sub_topics, only: [:index, :show]
  resources :listens, only: :index
  resources :users, only: [:index, :show]
  
  root 'sub_topics#index'
end
