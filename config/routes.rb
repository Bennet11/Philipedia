Rails.application.routes.draw do

  get 'users/show'

  devise_for :users

  resources :wikis

  resources :users, only: [:show, :index] do
    post 'downgrade_account' => 'users#downgrade_account', as: :downgrade_account
  end

  resources :charges, only: [:new, :create]

  get 'welcome/about'

  get 'welcome/index'
  
  root 'welcome#index'
end
