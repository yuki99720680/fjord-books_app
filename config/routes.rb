Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    get :followings, to: 'followings#index'
    get :followers, to: 'followers#index'
    resources :followings, only: %i(create destroy)
  end
end
