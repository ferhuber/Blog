Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
  

  get 'likes/create'
  get 'likes/destroy'

  root 'posts#index'

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  delete     '/logout'        =>  'sessions#destroy'
  get 'users/profile'   => 'users#show'

  resources :comments, only: [:edit, :update]
  resources :likes, only: [:index,:create, :destroy]

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :edit] do
    delete :destroy, on: :collection
  end
end
