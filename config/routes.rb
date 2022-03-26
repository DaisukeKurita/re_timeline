Rails.application.routes.draw do
  root to: 'tops#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  resources :users, only: [:show]

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
  end

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
