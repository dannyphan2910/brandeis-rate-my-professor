require 'test_helper'

class DoSearchTest < ActionDispatch::IntegrationTest

  test "can search for courses, professors, and departments" do
    get '/search', params: { filter: '', search_text: 'Test'}
    assert_response :success
    assert_select "h2", 4
    assert_select "h2", "Suggested Courses"
    assert_select "h2", "Suggested Professors"
    assert_select "h2", "Suggested Departments"
  end

  test "can search just courses" do
    get '/search', params: { filter: 'course', search_text: 'Test' }
    assert_response :success
    assert_select "h2", 2
    assert_select "h2", "Suggested Courses"
  end

  test "can filter courses to not show all offerings" do
    get '/search', params: { filter: 'course', search_text: 'Test' }
    assert_response :success
    assert_select "button#btn-filter-courses", "Show All Offerings"

    post '/search', params: { filter_general_courses: 'true', filter: 'course', search_text: 'Test' }, xhr: true
    assert_response :success
    assert_equal "text/javascript", @response.media_type
  end

  test "can search just professors" do
    get '/search', params: { filter: 'professor', search_text: 'Test'}
    assert_response :success
    assert_select "h2", 2
    assert_select "h2", "Suggested Professors"
  end

  test "can search just departments" do
    get '/search', params: { filter: 'department', search_text: 'Test'}
    assert_response :success
    assert_select "h2", 2
    assert_select "h2", "Suggested Departments"
  end
end
