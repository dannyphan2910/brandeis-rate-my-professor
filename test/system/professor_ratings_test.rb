require "application_system_test_case"

class ProfessorRatingsTest < ApplicationSystemTestCase
  setup do
    @professor_rating = professor_ratings(:one)
  end

  test "visiting the index" do
    visit professor_ratings_url
    assert_selector "h1", text: "Professor Ratings"
  end

  test "creating a Professor rating" do
    visit professor_ratings_url
    click_on "New Professor Rating"

    fill_in "Cat1", with: @professor_rating.cat1
    fill_in "Cat2", with: @professor_rating.cat2
    fill_in "Cat3", with: @professor_rating.cat3
    fill_in "Cat4", with: @professor_rating.cat4
    fill_in "Cat5", with: @professor_rating.cat5
    fill_in "Improvement", with: @professor_rating.improvement
    fill_in "Review", with: @professor_rating.review_id
    fill_in "Strength", with: @professor_rating.strength
    click_on "Create Professor rating"

    assert_text "Professor rating was successfully created"
    click_on "Back"
  end

  test "updating a Professor rating" do
    visit professor_ratings_url
    click_on "Edit", match: :first

    fill_in "Cat1", with: @professor_rating.cat1
    fill_in "Cat2", with: @professor_rating.cat2
    fill_in "Cat3", with: @professor_rating.cat3
    fill_in "Cat4", with: @professor_rating.cat4
    fill_in "Cat5", with: @professor_rating.cat5
    fill_in "Improvement", with: @professor_rating.improvement
    fill_in "Review", with: @professor_rating.review_id
    fill_in "Strength", with: @professor_rating.strength
    click_on "Update Professor rating"

    assert_text "Professor rating was successfully updated"
    click_on "Back"
  end

  test "destroying a Professor rating" do
    visit professor_ratings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Professor rating was successfully destroyed"
  end
end
