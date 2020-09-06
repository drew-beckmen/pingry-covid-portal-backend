Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      post '/login', to: 'auth#create'
      get '/pingrystats', to: 'stats#index'
      get '/summarystats', to: 'stats#summary'
      get '/studentinfo', to: "students#info"
      get '/student_details', to: "students#details"
      resources :users, only: [:show, :update, :create]
      resources :students, only: [:update, :show, :index]
      resources :quarantines, only: [:update, :show, :destroy, :index, :create]
      resources :isolations, only: [:update, :show, :destroy, :index, :create]
    end 
  end 
end
