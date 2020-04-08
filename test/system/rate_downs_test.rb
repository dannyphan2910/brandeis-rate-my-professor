require "application_system_test_case"

class RateDownsTest < ApplicationSystemTestCase
  setup do
    @rate_down = rate_downs(:one)
  end

  test "visiting the index" do
    visit rate_downs_url
    assert_selector "h1", text: "Rate Downs"
  end

  test "creating a Rate down" do
    visit rate_downs_url
    click_on "New Rate Down"

    fill_in "Review", with: @rate_down.review_id
    fill_in "User", with: @rate_down.user_id
    click_on "Create Rate down"

    assert_text "Rate down was successfully created"
    click_on "Back"
  end

  test "updating a Rate down" do
    visit rate_downs_url
    click_on "Edit", match: :first

    fill_in "Review", with: @rate_down.review_id
    fill_in "User", with: @rate_down.user_id
    click_on "Update Rate down"

    assert_text "Rate down was successfully updated"
    click_on "Back"
  end

  test "destroying a Rate down" do
    visit rate_downs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Rate down was successfully destroyed"
  end
end
