require 'test_helper'

class CourseRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_rating = course_ratings(:one)
  end

  test "should get index" do
    get course_ratings_url
    assert_response :success
  end

  test "should get new" do
    get new_course_rating_url
    assert_response :success
  end

  test "should create course_rating" do
    assert_difference('CourseRating.count') do
      post course_ratings_url, params: { course_rating: { cat1: @course_rating.cat1, cat2: @course_rating.cat2, cat3: @course_rating.cat3, cat4: @course_rating.cat4, cat5: @course_rating.cat5, content: @course_rating.content, review_id: @course_rating.review_id } }
    end

    assert_redirected_to course_rating_url(CourseRating.last)
  end

  test "should show course_rating" do
    get course_rating_url(@course_rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_rating_url(@course_rating)
    assert_response :success
  end

  test "should update course_rating" do
    patch course_rating_url(@course_rating), params: { course_rating: { cat1: @course_rating.cat1, cat2: @course_rating.cat2, cat3: @course_rating.cat3, cat4: @course_rating.cat4, cat5: @course_rating.cat5, content: @course_rating.content, review_id: @course_rating.review_id } }
    assert_redirected_to course_rating_url(@course_rating)
  end

  test "should destroy course_rating" do
    assert_difference('CourseRating.count', -1) do
      delete course_rating_url(@course_rating)
    end

    assert_redirected_to course_ratings_url
  end
end
