Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  root to: 'books#index'

  resources :users, only: %i[index show]
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
