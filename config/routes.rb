# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Admin', at: 'admin', controllers: {
        registrations: 'api/v1/admin/registrations'
      }
      namespace :admin do
        resources :sessions, only: %i[index]
      end
      resources :events, only: %i[index create show update]
      resources :musics, only: %i[index create show update] do
        get 'search' => 'musics#search', on: :collection
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
