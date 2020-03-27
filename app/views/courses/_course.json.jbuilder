json.extract! course, :id, :professor_id, :semester, :year, :course_title, :course_description, :course_code, :created_at, :updated_at
json.url course_url(course, format: :json)
