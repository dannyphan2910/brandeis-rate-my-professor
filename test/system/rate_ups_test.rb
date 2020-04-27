require "application_system_test_case"

class RateUpsTest < ApplicationSystemTestCase
  setup do
    @rate_up = rate_ups(:one)
  end

  test "visiting the index" do
    visit rate_ups_url
    assert_selector "h1", text: "Rate Ups"
  end

  test "creating a Rate up" do
    visit rate_ups_url
    click_on "New Rate Up"

    fill_in "Review", with: @rate_up.review_id
    fill_in "User", with: @rate_up.user_id
    click_on "Create Rate up"

    assert_text "Rate up was successfully created"
    click_on "Back"
  end

  test "updating a Rate up" do
    visit rate_ups_url
    click_on "Edit", match: :first

    fill_in "Review", with: @rate_up.review_id
    fill_in "User", with: @rate_up.user_id
    click_on "Update Rate up"

    assert_text "Rate up was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate up" do
    visit rate_ups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate up was successfully destroyed"
  end
end
