require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get view_profile" do
    get profile_view_profile_url
    assert_response :success
  end

end
