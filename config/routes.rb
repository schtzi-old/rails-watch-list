Rails.application.routes.draw do
  get 'lists/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  delete '/bookmarks/:id', to: 'bookmarks#destroy', as: 'delete_bookmark'

  resources :lists, only: %i[index show new create] do
    resources :bookmarks, only: %i[new create]
  end
end
