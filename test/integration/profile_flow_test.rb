require 'test_helper'

class ProfileFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :reviews, :courses, :professors, :departments

  setup do
    @user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    sign_in @user
  end

  test "can view profile" do
    get '/view_profile'
    assert_response :success

    assert_select "img.image"
    assert_select "button.message-button"
    assert_select "input.btn-outline-danger"
  end

  test "can access messenger" do
    get '/messenger_home'
    assert_response :success

    assert_select "span.h2", "My Inbox"
  end

  test "can log out" do
    delete destroy_user_session_path
    assert_redirected_to root_path
  end

  test "can search for courses" do 
    post '/view_profile', params: { search_text_courses: 'test' }, xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end

  test "can edit a review" do 
    review = reviews(:one)
    get edit_review_path(id: review.id), xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end

  test "can delete a review" do 
    review = reviews(:one)
    delete "/reviews/#{review.id}"
    assert_redirected_to '/view_profile'
  end
end
