Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "foods#index"

  resources :users do
    resources :foods, except: %i[edit update]
    resources :recipes, except: %i[edit update] 
  end
  resources :recipes, except: %i[edit update] do
    resources :recipefoods, except: %i[edit update]
    collection do
      get 'public'
    end
    member do
      get 'shoppinglist'
    end
  end
end
