Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"

  resources :users do
    resources :foods
    resources :recipes, except: %i[edit update] 
  end
  resources :recipes, except: %i[edit update] do
    resources :recipefoods
    collection do
      get 'public'
    end
  end
end
