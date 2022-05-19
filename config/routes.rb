Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
  resources :reports do
    resources :comments, only: [:create], module: :reports
  end
  resources :books do
    resources :comments, only: [:create], module: :books
  end
  resources :comments, only: [:destroy]
end
