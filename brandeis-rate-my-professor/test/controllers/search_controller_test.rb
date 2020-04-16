require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get search_result" do
    get '/search'
    assert_response :success
  end

end
