require 'test_helper'

class RateUpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_up = rate_ups(:one)
  end

  test "should get index" do
    get rate_ups_url
    assert_response :success
  end

  test "should get new" do
    get new_rate_up_url
    assert_response :success
  end

  test "should create rate_up" do
    assert_difference('RateUp.count') do
      post rate_ups_url, params: { rate_up: { review_id: @rate_up.review_id, user_id: @rate_up.user_id } }
    end

    assert_redirected_to rate_up_url(RateUp.last)
  end

  test "should show rate_up" do
    get rate_up_url(@rate_up)
    assert_response :success
  end

  test "should get edit" do
    get edit_rate_up_url(@rate_up)
    assert_response :success
  end

  test "should update rate_up" do
    patch rate_up_url(@rate_up), params: { rate_up: { review_id: @rate_up.review_id, user_id: @rate_up.user_id } }
    assert_redirected_to rate_up_url(@rate_up)
  end

  test "should destroy rate_up" do
    assert_difference('RateUp.count', -1) do
      delete rate_up_url(@rate_up)
    end

    assert_redirected_to rate_ups_url
  end
end
