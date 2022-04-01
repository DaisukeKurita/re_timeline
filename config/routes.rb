Rails.application.routes.draw do
  root to: 'tops#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in'
    post 'users/sign_up/confirm', to: 'users/registrations#confirm'
  end
  
  resources :users, only: [:show]

  resources :groups do
    resources :groupings, only: %w(create update destroy)
    resources :blogs do
      post 'confirm', on: :collection
      patch 'notice_switching', on: :member
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
