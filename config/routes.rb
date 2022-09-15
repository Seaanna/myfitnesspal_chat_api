Rails.application.routes.draw do
  get 'chats/user/:username', to: 'chats#chats_by_username', as: 'chats_by_username'

  resources :chats
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "chats#index"
end
