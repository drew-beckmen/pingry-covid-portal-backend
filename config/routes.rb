Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      post '/login', to: 'auth#create'
      get '/pingrystats', to: 'stats#index'
      get '/summarystats', to: 'stats#summary'
      get '/studentinfo', to: "students#info"
      get '/student_details', to: "students#details"
      get '/detailedstats', to: "stats#details"
      get '/graphs', to: "stats#q_and_i_each_campus"
      get '/percentages', to: "stats#past_future_7_details"
      get '/veracrossids', to: "stats#veracross_ids"
      get '/bygrade', to: "stats#grade_level_data"
      get '/data_export', to: "exports#data_export"
      resources :users, only: [:show, :update, :create]
      resources :students, only: [:update, :show, :index, :create]
      resources :quarantines, only: [:update, :show, :destroy, :index, :create]
      resources :isolations, only: [:update, :show, :destroy, :index, :create]
      resources :contacts, only: [:show, :destroy, :index, :create]
    end 
  end 
end
