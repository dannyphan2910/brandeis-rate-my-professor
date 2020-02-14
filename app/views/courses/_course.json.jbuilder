json.extract! course, :id, :prof_id, :semester, :year, :course_title, :course_description, :created_at, :updated_at
json.url course_url(course, format: :json)
