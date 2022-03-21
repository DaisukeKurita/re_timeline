Rails.application.routes.draw do
  root to: 'tops#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  
  resources :groups do
    resources :groupings, only: %w(create update destroy )
    resources :blogs do
      collection do
        post :confirm
      end
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
