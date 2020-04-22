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
Enrollment.delete_all

require 'json'

course_file = File.read('public/json/course.json')
instructor_file = File.read('public/json/instructor.json')
subject_file = File.read('public/json/subject.json')

course_hash = JSON.parse(course_file)
instructor_hash = JSON.parse(instructor_file)
subject_hash = JSON.parse(subject_file)

subjects = []
subject_hash.each do |subject|
    subjects.push(subject['name'])
end

100.times do 
    pass = Faker::Internet.password(min_length: 10, max_length: 20)
    u = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: pass, password_confirmation: pass, is_admin:false)
end

instructor_hash.each do |instructor|
    p = Professor.create(prof_first_name: instructor['first'], prof_last_name: instructor['last'], prof_email: instructor['email'], dept_name: subjects.sample, prof_info: Faker::Job.title)
end

assign_hash = {
    "MATH" => "Mathematics",
    "COSI" => "Computer Science",
    "ECON" => "Economics",
    "ENG" => "English",
    "ANTH" => "Anthropology",
    "POL" => "Politics",
    "IGS" => "International and Global Studies",
    "PSYC" => "Psychology",
    "BUS" => ["Economics", "Business", "International Business School"],
    "FIN" => ["Business", "International Business School"],
    "PHYS" => ["Physics", "Biophysics and Structural Biology", "Biochemistry and Biophysics"],
    "CHEM" => ["Biochemistry and Biophysics", "Biochemistry", "Chemistry"],
    "BCHM" => "Biochemistry and Biophysics",
    "BIO" => ["Molecular and Cell Biology", "Quantitative Biology", "Biophysics and Structural Biology", "Biochemistry and Biophysics", "Biochemistry"],
    "NEJS" => ["Hornstein Jewish Professional Leadership Program", "Islamic and Middle Eastern Studies"],
    "KOR" => "Korean",
    "JAPN" => "Japanese",
    "RUS" => "Russian Studies",
    "MUS" => "Music",
    "THA" => "Theater Arts",
    "HBRW" => "Hebrew",
    "FREN" => "French and Francophone Studies",
    "ARBC" => "Arabic Language and Literature", 
    "HINDI" => "Hindi",
    "LAT" => "Latin",
    "GER" => "German Studies",
    "CHIN" => "Chinese",
    "GRK" => "Greek",
    "ITAL" => "Italian Studies"
}


course_hash.each do |course| 
    course_code = course['code'].split(' ')[0]
    if assign_hash.keys.include? course_code
        gen_c = GeneralCourse.create(course_code: course['code'], course_title: course['name'], course_description: course['description'])
        5.times do 
            p_id = Professor.where(dept_name: assign_hash[course_code]).sample.id
            c = Course.create(professor_id: p_id, semester: ['Fall', 'Spring'].sample, year: Faker::Number.between(from: 2005, to: 2020), general_course_id: gen_c.id)
        end
    end
end


2000.times do
    c_id = Course.all.sample.id
    r = Review.create(user_id: User.all.sample.id, course_id: c_id, professor_id: Course.find(c_id).professor.id, title: Faker::Movie.quote)
    course_r = CourseRating.create(review_id: r.id, cat1: Faker::Number.between(from: 1, to: 5), cat2: Faker::Number.between(from: 1, to: 5), cat3: Faker::Number.between(from: 1, to: 5), cat4: Faker::Number.between(from: 1, to: 5), cat5: Faker::Number.between(from: 1, to: 5), content: Faker::Quote.famous_last_words)
    prof_r = ProfessorRating.create(review_id: r.id, cat1: Faker::Number.between(from: 1, to: 5), cat2: Faker::Number.between(from: 1, to: 5), cat3: Faker::Number.between(from: 1, to: 5), cat4: Faker::Number.between(from: 1, to: 5), cat5: Faker::Number.between(from: 1, to: 5), strength: Faker::Quote.famous_last_words, improvement: Faker::Quote.famous_last_words)

    rand(0..5).times do
        vote_up = RateUp.create(user_id: User.all.sample.id, review_id: r.id)
    end

    rand(0..5).times do
        vote_down = RateDown.create(user_id: User.all.sample.id, review_id: r.id)
    end
end