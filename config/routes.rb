Rails.application.routes.draw do

  resources :review_forms
  #get "modal/new_release" => 'modal#new_release', :as => new_release
  get "reviews/new_release" => 'reviews#new_release', :as => :new_release

  resources :professors
  resources :courses
  resources :gets
  resources :professor_ratings
  resources :course_ratings
  resources :reviews
  resources :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#render_home'
end
