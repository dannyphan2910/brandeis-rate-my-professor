require "application_system_test_case"

class GeneralCoursesTest < ApplicationSystemTestCase
  setup do
    @general_course = general_courses(:one)
  end

  test "visiting the index" do
    visit general_courses_url
    assert_selector "h1", text: "General Courses"
  end

  test "creating a General course" do
    visit general_courses_url
    click_on "New General Course"

    fill_in "Course code", with: @general_course.course_code
    fill_in "Course description", with: @general_course.course_description
    fill_in "Course title", with: @general_course.course_title
    click_on "Create General course"

    assert_text "General course was successfully created"
    click_on "Back"
  end

  test "updating a General course" do
    visit general_courses_url
    click_on "Edit", match: :first

    fill_in "Course code", with: @general_course.course_code
    fill_in "Course description", with: @general_course.course_description
    fill_in "Course title", with: @general_course.course_title
    click_on "Update General course"

    assert_text "General course was successfully updated"
    click_on "Back"
  end

  test "destroying a General course" do
    visit general_courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "General course was successfully destroyed"
  end
end
