require "application_system_test_case"

class CourseRatingsTest < ApplicationSystemTestCase
  setup do
    @course_rating = course_ratings(:one)
  end

  test "visiting the index" do
    visit course_ratings_url
    assert_selector "h1", text: "Course Ratings"
  end

  test "creating a Course rating" do
    visit course_ratings_url
    click_on "New Course Rating"

    fill_in "Cat1", with: @course_rating.cat1
    fill_in "Cat2", with: @course_rating.cat2
    fill_in "Cat3", with: @course_rating.cat3
    fill_in "Cat4", with: @course_rating.cat4
    fill_in "Cat5", with: @course_rating.cat5
    fill_in "Content", with: @course_rating.content
    fill_in "Review", with: @course_rating.review_id
    click_on "Create Course rating"

    assert_text "Course rating was successfully created"
    click_on "Back"
  end

  test "updating a Course rating" do
    visit course_ratings_url
    click_on "Edit", match: :first

    fill_in "Cat1", with: @course_rating.cat1
    fill_in "Cat2", with: @course_rating.cat2
    fill_in "Cat3", with: @course_rating.cat3
    fill_in "Cat4", with: @course_rating.cat4
    fill_in "Cat5", with: @course_rating.cat5
    fill_in "Content", with: @course_rating.content
    fill_in "Review", with: @course_rating.review_id
    click_on "Update Course rating"

    assert_text "Course rating was successfully updated"
    click_on "Back"
  end

  test "destroying a Course rating" do
    visit course_ratings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course rating was successfully destroyed"
  end
end
