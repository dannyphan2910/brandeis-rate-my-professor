Rails.application.routes.draw do
  resources :general_courses
  resources :professors
  resources :courses
  resources :professor_ratings
  resources :course_ratings
  resources :reviews
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get :autocomplete, to: 'pages#autocomplete'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'logout', to: 'sessions#destroy'

  get 'users/new', to: 'users#new'
  post 'users', to: 'users#create'

  get 'search', to: 'search#search_result'
  post 'search', to: 'search#search_result'

  get 'view_profile', to: 'profile#view_profile'
  get 'filter_course_by_year' => 'reviews#filter_course_by_year'
  get 'filter_professor_by_course' => 'reviews#filter_professor_by_course'
  root 'sessions#welcome'
end
