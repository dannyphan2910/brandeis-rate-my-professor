Rails.application.routes.draw do
  resources :professors
  resources :courses
  resources :gets
  resources :professor_ratings
  resources :course_ratings
  resources :reviews
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
