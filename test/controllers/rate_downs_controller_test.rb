require 'test_helper'

class RateDownsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate_down = rate_downs(:one)
  end

  # test "should get index" do
  #   get rate_downs_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_rate_down_url
  #   assert_response :success
  # end

  # test "should create rate_down" do
  #   assert_difference('RateDown.count') do
  #     post rate_downs_url, params: { rate_down: { review_id: @rate_down.review_id, user_id: @rate_down.user_id } }
  #   end

  #   assert_redirected_to rate_down_url(RateDown.last)
  # end

  # test "should show rate_down" do
  #   get rate_down_url(@rate_down)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_rate_down_url(@rate_down)
  #   assert_response :success
  # end

  # test "should update rate_down" do
  #   patch rate_down_url(@rate_down), params: { rate_down: { review_id: @rate_down.review_id, user_id: @rate_down.user_id } }
  #   assert_redirected_to rate_down_url(@rate_down)
  # end

  # test "should destroy rate_down" do
  #   assert_difference('RateDown.count', -1) do
  #     delete rate_down_url(@rate_down)
  #   end

  #   assert_redirected_to rate_downs_url
  # end
end
