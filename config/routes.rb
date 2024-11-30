Rails.application.routes.draw do
  root 'house#index'

  devise_for :users

  resources :users, only: [:index, :show], param: :username do
    member do
      post :follow_request
      delete :unfollow_request
      delete :cancel_follow_request
    end
  end

  resources :photos do
    collection do
      get :feed
      get :discovery
    end
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :follow_requests, only: [:create, :destroy] do
    member do
      patch :accept
      patch :reject
    end
  end
end
