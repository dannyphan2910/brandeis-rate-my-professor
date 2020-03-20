require "application_system_test_case"

class ReviewFormsTest < ApplicationSystemTestCase
  setup do
    @review_form = review_forms(:one)
  end

  test "visiting the index" do
    visit review_forms_url
    assert_selector "h1", text: "Review Forms"
  end

  test "creating a Review form" do
    visit review_forms_url
    click_on "New Review Form"

    fill_in "Review", with: @review_form.review
    click_on "Create Review form"

    assert_text "Review form was successfully created"
    click_on "Back"
  end

  test "updating a Review form" do
    visit review_forms_url
    click_on "Edit", match: :first

    fill_in "Review", with: @review_form.review
    click_on "Update Review form"

    assert_text "Review form was successfully updated"
    click_on "Back"
  end

  test "destroying a Review form" do
    visit review_forms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Review form was successfully destroyed"
  end
end
