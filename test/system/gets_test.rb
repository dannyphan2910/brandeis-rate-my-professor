require "application_system_test_case"

class GetsTest < ApplicationSystemTestCase
  setup do
    @get = gets(:one)
  end

  test "visiting the index" do
    visit gets_url
    assert_selector "h1", text: "Gets"
  end

  test "creating a Get" do
    visit gets_url
    click_on "New Get"

    fill_in "Course", with: @get.course_id
    fill_in "Review", with: @get.review_id
    click_on "Create Get"

    assert_text "Get was successfully created"
    click_on "Back"
  end

  test "updating a Get" do
    visit gets_url
    click_on "Edit", match: :first

    fill_in "Course", with: @get.course_id
    fill_in "Review", with: @get.review_id
    click_on "Update Get"

    assert_text "Get was successfully updated"
    click_on "Back"
  end

  test "destroying a Get" do
    visit gets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Get was successfully destroyed"
  end
end
