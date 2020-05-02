require 'test_helper'

class MakeReviewTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    sign_in @user
  end

  test "can see review button after signed in" do
    get root_path
    assert_response :success
    assert_select "button.main-btn-review", "Make A Review"
    assert_select "div.modal"
  end

  test "cannot see review button after signed out" do
    sign_out @user
    get root_path
    assert_response :success
    assert_select "input.main-btn-warning", value: "Sign in and Make A Review"
  end

  test "can make a review in other pages" do
    get root_path
    assert_select "nav input#search_text", false

    get '/search', params: { filter: '', search_text: 'Test'}
    assert_select "nav input#search_text"
  end

  test "can fill out a review in home page" do
    get root_path
    assert_response :success
    assert_select "div.modal form"
    # check all necessary select boxes + text fields
    assert_select "select#review_course_year"
    assert_select "select#review_course_id"
    assert_select "select#review_professor_id"
    assert_select "input#review_title"
    assert_select "h5", "Course Ratings"
    assert_select "h5", "Professor Ratings"
    assert_select "textarea#review_course_rating_attributes_content"
    assert_select "textarea#review_professor_rating_attributes_strength"
    assert_select "textarea#review_professor_rating_attributes_improvement"
    assert_select "input.form-submission"
  end

  test "can submit a review form" do 
    review = { user_id: @user.id, title: 'test', course_id: 1, professor_id: 1, 
      professor_rating_attributes: {
        cat1: 1, cat2: 1, cat3: 1, cat4: 1, cat5: 1, strength: 'test', improvement: 'test'
      },
      course_rating_attributes: {
        cat1: 1, cat2: 1, cat3: 1, cat4: 1, cat5: 1, content: 'test'
      }
    }
    post '/reviews', params: { review: review }, xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end
end
