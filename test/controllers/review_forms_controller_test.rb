require 'test_helper'

class ReviewFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review_form = review_forms(:one)
  end

  test "should get index" do
    get review_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_review_form_url
    assert_response :success
  end

  test "should create review_form" do
    assert_difference('ReviewForm.count') do
      post review_forms_url, params: { review_form: { review: @review_form.review } }
    end

    assert_redirected_to review_form_url(ReviewForm.last)
  end

  test "should show review_form" do
    get review_form_url(@review_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_review_form_url(@review_form)
    assert_response :success
  end

  test "should update review_form" do
    patch review_form_url(@review_form), params: { review_form: { review: @review_form.review } }
    assert_redirected_to review_form_url(@review_form)
  end

  test "should destroy review_form" do
    assert_difference('ReviewForm.count', -1) do
      delete review_form_url(@review_form)
    end

    assert_redirected_to review_forms_url
  end
end
