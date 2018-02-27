Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :create] do
    collection do
      post :signin
      post :signup
    end
  end
end
