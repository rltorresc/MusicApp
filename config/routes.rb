Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "sessions#new"
  resources :users, only: [:show, :create, :new, :index] do
    collection do
      get 'activate'
    end
    member do
      patch :make_admin
    end
  end
  resources :sessions, only: [:create, :new, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :bands do 
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :show, :edit, :update, :destroy] do
    resources :tracks, only: [:new]
  end
  
  resources :tracks, only: [:create, :show, :edit, :update, :destroy] do
    resources :notes, only: [:new]
  end

  resources :notes, only: [:create, :show, :edit, :update, :destroy]

  
end
