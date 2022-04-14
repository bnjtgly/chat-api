Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :users, param: :user_id, only: %i[index]
    get 'users/get_users', to: 'users#get_users'
  end

  resources :messages, only: [:index, :create]
  resources :chatrooms, only: [:index, :create, :show]

  mount ActionCable.server => './cable'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  }, controllers: { sessions: 'sessions', registrations: 'registrations' }

end
