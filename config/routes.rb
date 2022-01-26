Rails.application.routes.draw do
  devise_for :users
  root to: 'tops#index'
  resources :groups
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
