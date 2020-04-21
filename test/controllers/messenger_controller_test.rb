require 'test_helper'

class MessengerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get messenger_show_url
    assert_response :success
  end

end
