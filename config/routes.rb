Rails.application.routes.draw do
  devise_for :users
  get 'welcome/about'

  get 'welcome/index'

  root 'welcome#index'
end
