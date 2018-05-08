Rails.application.routes.draw do
  get 'users/most_comments', to: "users#most_comments"

  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show, :edit, :update] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
end
