Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root "events#index"

  resources :users, only: :show do
    member do
      get :join
    end
  end

  resources :events do
    resources :participations, only: [:create, :destroy]
    get 'search', on: :collection
  end
end
