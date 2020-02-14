require 'test_helper'

class ProfessorRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @professor_rating = professor_ratings(:one)
  end

  test "should get index" do
    get professor_ratings_url
    assert_response :success
  end

  test "should get new" do
    get new_professor_rating_url
    assert_response :success
  end

  test "should create professor_rating" do
    assert_difference('ProfessorRating.count') do
      post professor_ratings_url, params: { professor_rating: { cat1: @professor_rating.cat1, cat2: @professor_rating.cat2, cat3: @professor_rating.cat3, cat4: @professor_rating.cat4, cat5: @professor_rating.cat5, improvement: @professor_rating.improvement, review_id: @professor_rating.review_id, strength: @professor_rating.strength } }
    end

    assert_redirected_to professor_rating_url(ProfessorRating.last)
  end

  test "should show professor_rating" do
    get professor_rating_url(@professor_rating)
    assert_response :success
  end

  test "should get edit" do
    get edit_professor_rating_url(@professor_rating)
    assert_response :success
  end

  test "should update professor_rating" do
    patch professor_rating_url(@professor_rating), params: { professor_rating: { cat1: @professor_rating.cat1, cat2: @professor_rating.cat2, cat3: @professor_rating.cat3, cat4: @professor_rating.cat4, cat5: @professor_rating.cat5, improvement: @professor_rating.improvement, review_id: @professor_rating.review_id, strength: @professor_rating.strength } }
    assert_redirected_to professor_rating_url(@professor_rating)
  end

  test "should destroy professor_rating" do
    assert_difference('ProfessorRating.count', -1) do
      delete professor_rating_url(@professor_rating)
    end

    assert_redirected_to professor_ratings_url
  end
end
