Rails.application.routes.draw do
  devise_for :users, path: '/', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'users' }, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  resources :conversations do
    resources :messages, only: [:create]
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :enrollments
  resources :rate_downs
  resources :rate_ups
  resources :general_courses
  resources :professors
  resources :courses
  resources :professor_ratings
  resources :course_ratings
  resources :reviews do
    collection do
      get :open_edit_modal
    end
  end
  resources :users, only: [:show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # get 'welcome', to: 'sessions#welcome'
  # get 'logout', to: 'sessions#destroy'

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

  root 'sessions#welcome'
end
