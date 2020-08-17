Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      post '/login', to: 'auth#create'
      resources :users, only: [:show, :update]
      resources :students, only: [:update, :show, :index]
      resources :quarantines, only: [:update, :show, :destroy, :index, :create]
      resources :isolations, only: [:update, :show, :destroy, :index, :create]
    end 
  end 
end
