Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    resources :libraries, only: [] do
      member do
        get 'books', to: 'libraries#books'
      end
    end
  end
end
