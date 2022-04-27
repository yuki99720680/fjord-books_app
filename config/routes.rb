Rails.application.routes.draw do
  get 'followings/index'
  get 'followings/create'
  get 'followings/destroy'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show)
end
