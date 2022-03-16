Rails.application.routes.draw do
  get 'blogs/index'
  get 'blogs/show'
  get 'blogs/new'
  get 'blogs/edit'
  root to: 'tops#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  
  resources :groups do
    resources :groupings, only: %w(create update destroy )
    resources :blogs
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
