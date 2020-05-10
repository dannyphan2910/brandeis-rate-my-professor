Rails.application.routes.draw do
  resources :preferences, only: [:create]
  resources :departments, only: [:show]
  devise_for :users, path: '/', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'users' }, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }

  resources :conversations, only: [:create, :destroy]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :enrollments, only: [:create, :destroy]
  resources :rate_downs, only: [:create, :destroy]
  resources :rate_ups, only: [:create, :destroy]
  resources :general_courses, only: [:show] do
    member do
      post 'match'
    end
  end

  resources :professors, only: [:show]
  resources :reviews do
    collection do
      get :open_edit_modal
    end
  end
  resources :users, only: [:show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'search', to: 'search#search_result'
  post 'search', to: 'search#search_result'

  get 'view_profile', to: 'profile#view_profile'
  post 'view_profile', to: 'profile#view_profile'
  post 'upload_avatar', to: 'profile#upload_avatar'

  get 'filter_course_by_year' => 'reviews#filter_course_by_year'
  get 'filter_professor_by_course' => 'reviews#filter_professor_by_course'
  get 'open_edit_modal' => 'reviews#open_edit_modal'

  get 'messenger_home', to: 'messenger#show'
  post 'message/:id', to: 'messenger#message'

  get 'contact', to: 'contact#index'
  post 'contact', to: 'contact#email'

  root 'sessions#welcome'
end
