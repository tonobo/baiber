Rails.application.routes.draw do
  resources :user_file_groups
  resources :filters
  resources :emails
  resources :user_files
  devise_for :users
  post "/emails/:id/test", to: 'emails#test', as: :test_email
  root to: 'overview#index'
end
