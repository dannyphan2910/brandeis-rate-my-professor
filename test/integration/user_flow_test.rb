require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  fixtures :users
  include Devise::Test::IntegrationHelpers

  test "can see home page" do
    get '/'
    assert_response :success
    assert_select "nav"
    assert_select "h2", 2
  end

  test "can create an account" do
    get '/users/new'
    assert_response :success
    
    post '/users', params: { user: { first_name: 'Test', last_name: 'Testinf', email: 'abc@test.com', password: '123123', password_confirmation: '123123' }}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_equal path, '/'
  end

  test "can log in" do
    get '/login'
    assert_response :success
    
    post '/login', params: { email: users(:one).email, password: '123123' }
    assert_response :success
    assert_equal path, '/login'
  end
end
