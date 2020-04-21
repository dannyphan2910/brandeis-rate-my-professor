require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get '/welcome'
    assert_response :success
  end
end
