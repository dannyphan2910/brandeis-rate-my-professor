Rails.application.routes.draw do

  resources :professors
  resources :courses
  resources :professor_ratings
  resources :course_ratings
  resources :reviews

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#render_home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'logout', to: 'sessions#destroy'

  get 'users/new', to: 'users#new'
  post 'users', to: 'users#create'

  root 'sessions#welcome'
end
