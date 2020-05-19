# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Review.delete_all
CourseRating.delete_all
ProfessorRating.delete_all
RateUp.delete_all
RateDown.delete_all
Course.delete_all
GeneralCourse.delete_all
Professor.delete_all
Department.delete_all
Enrollment.delete_all
Conversation.delete_all
Message.delete_all

require 'json'
require 'open-uri'

url = 'https://www.cs.brandeis.edu/~prakhar/dataset.json'

courses = {}
sections = {}
terms = {}
subjects = {}
instructors = {}

URI.open(url) do |f|
    f.each_line do |line| 
        line = JSON.parse(line);
        case line["type"]
        when "course"
            courses[line["id"]] = line
        when "section"
            sections[line["id"]] = line
        when "term"
            terms[line["id"]] = line
        when "subject"
            subjects[line["id"]] = line
        when "instructor"
            instructors[line["id"]] = line
        end
    end
end

puts 'DONE READ JSON'

# MODIFY THESE LINES TO SEED FULL DATA (> 500k data)
limit_users = 10 # default (if commented): 1000 users (excluding 1 super-admin)
limit_course_prof = 1500 # comment this line to load full dataset
limit_review = 1500 # default (if commented): 10000 reviews
limit_votes = 2 # default (if commented): 0 -> 50 rates up/down per review
###

num_users = limit_users || 1000
num_users.times do 
    pass = Faker::Internet.password(min_length: 10, max_length: 20)
    u = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: pass, password_confirmation: pass, is_admin: false)
end

count_course_prof = 0
sections.each_value do |section|
    course_id = section["course"]
    course = courses[course_id]
    if !GeneralCourse.exists?(course_code: course["code"])
        gc = GeneralCourse.create(course_code: course["code"], course_title: course["name"], course_description: course["description"]) 
    else
        gc = GeneralCourse.find_by(course_code: course["code"])
    end

    subject_id = course["subjects"][0]["id"]
    subject = subjects[subject_id]
    if subject
        if !Department.exists?(dept_name: subject["name"])
            dept = Department.create(dept_name: subject["name"]) 
        else
            dept = Department.find_by(dept_name: subject["name"]) 
        end
    else 
        dept = Department.all.sample
    end

    instructor_id = section["instructors"][0]
    instructor = instructors[instructor_id]
    if !Professor.exists?(prof_email: instructor["email"])
        prof = Professor.create(prof_first_name: instructor["first"], prof_last_name: instructor["last"], prof_email: instructor["email"], department_id: dept.id, prof_info: instructor["comment"])
    else
        prof = Professor.find_by(prof_email: instructor["email"])
    end

    term_id = course["term"]
    term = terms[term_id]
    semester_full = term["name"].split(" ", 2)
    c = Course.create(general_course_id: gc.id, professor_id: prof.id, semester: semester_full[0], year: semester_full[1].to_i)

    count_course_prof += 1
    if limit_course_prof && limit_course_prof <= count_course_prof
        break
    end
end

count_review = 0
num_reviews = limit_review || 10000
max_rates = limit_votes || 50
num_reviews.times do
    c_id = Course.pluck(:id).sample
    r = Review.create(user_id: User.pluck(:id).sample, course_id: c_id, professor_id: Course.find(c_id).professor.id, title: Faker::Movie.quote)
    course_r = CourseRating.create(review_id: r.id, cat1: Faker::Number.between(from: 1, to: 5), cat2: Faker::Number.between(from: 1, to: 5), cat3: Faker::Number.between(from: 1, to: 5), cat4: Faker::Number.between(from: 1, to: 5), cat5: Faker::Number.between(from: 1, to: 5), content: Faker::Quote.famous_last_words)
    prof_r = ProfessorRating.create(review_id: r.id, cat1: Faker::Number.between(from: 1, to: 5), cat2: Faker::Number.between(from: 1, to: 5), cat3: Faker::Number.between(from: 1, to: 5), cat4: Faker::Number.between(from: 1, to: 5), cat5: Faker::Number.between(from: 1, to: 5), strength: Faker::Quote.famous_last_words, improvement: Faker::Quote.famous_last_words)

    rand(0..max_rates).times do
        vote_up = RateUp.create(user_id: User.pluck(:id).sample, review_id: r.id)
    end

    rand(0..max_rates).times do
        vote_down = RateDown.create(user_id: User.pluck(:id).sample, review_id: r.id)
    end

    count_review += 1
    puts count_review
end

admin = User.create(first_name: "Admin", last_name: "Brandeis", email: "admin@brandeis.edu", password: "brandeis_admin", password_confirmation: "brandeis_admin", is_admin: true)