require "application_system_test_case"

class ProfessorsTest < ApplicationSystemTestCase
  setup do
    @professor = professors(:one)
  end

  test "visiting the index" do
    visit professors_url
    assert_selector "h1", text: "Professors"
  end

  test "creating a Professor" do
    visit professors_url
    click_on "New Professor"

    fill_in "Dept name", with: @professor.dept_name
    fill_in "Prof email", with: @professor.prof_email
    fill_in "Prof first name", with: @professor.prof_first_name
    fill_in "Prof info", with: @professor.prof_info
    fill_in "Prof last name", with: @professor.prof_last_name
    click_on "Create Professor"

    assert_text "Professor was successfully created"
    click_on "Back"
  end

  test "updating a Professor" do
    visit professors_url
    click_on "Edit", match: :first

    fill_in "Dept name", with: @professor.dept_name
    fill_in "Prof email", with: @professor.prof_email
    fill_in "Prof first name", with: @professor.prof_first_name
    fill_in "Prof info", with: @professor.prof_info
    fill_in "Prof last name", with: @professor.prof_last_name
    click_on "Update Professor"

    assert_text "Professor was successfully updated"
    click_on "Back"
  end

  test "destroying a Professor" do
    visit professors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Professor was successfully destroyed"
  end
end
