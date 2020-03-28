require 'test_helper'

class GeneralCoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @general_course = general_courses(:one)
  end

  test "should get index" do
    get general_courses_url
    assert_response :success
  end

  test "should get new" do
    get new_general_course_url
    assert_response :success
  end

  test "should create general_course" do
    assert_difference('GeneralCourse.count') do
      post general_courses_url, params: { general_course: { course_code: @general_course.course_code, course_description: @general_course.course_description, course_title: @general_course.course_title } }
    end

    assert_redirected_to general_course_url(GeneralCourse.last)
  end

  test "should show general_course" do
    get general_course_url(@general_course)
    assert_response :success
  end

  test "should get edit" do
    get edit_general_course_url(@general_course)
    assert_response :success
  end

  test "should update general_course" do
    patch general_course_url(@general_course), params: { general_course: { course_code: @general_course.course_code, course_description: @general_course.course_description, course_title: @general_course.course_title } }
    assert_redirected_to general_course_url(@general_course)
  end

  test "should destroy general_course" do
    assert_difference('GeneralCourse.count', -1) do
      delete general_course_url(@general_course)
    end

    assert_redirected_to general_courses_url
  end
end
