Rails.application.routes.draw do
  devise_for :users, path: '/', path_names: { sign_up: 'users/new', sign_in: 'login', sign_out: 'logout' }, controllers: {
    sessions: 'users/sessions'
  }

  resources :conversations do
    resources :messages, only: [:create]
  end
  resources :enrollments
  resources :rate_downs
  resources :rate_ups
  resources :general_courses
  resources :professors
  resources :courses
  resources :professor_ratings
  resources :course_ratings
  resources :reviews
  resources :users, only: [:show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'logout', to: 'sessions#destroy'

  get 'search', to: 'search#search_result'
  post 'search', to: 'search#search_result'

  get 'view_profile', to: 'profile#view_profile'
  post 'view_profile', to: 'profile#view_profile'

  get 'messenger_home', to: 'messenger#show'
  post 'message/:id', to: 'messenger#message'

  root 'sessions#welcome'
end
