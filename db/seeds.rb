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
Course.delete_all
Professor.delete_all

50.times do 
    u = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password(min_length: 10, max_length: 20))
end
25.times do 
    p = Professor.create(prof_first_name: Faker::Name.first_name, prof_last_name: Faker::Name.last_name, prof_email: Faker::Internet.email, dept_name: Faker::Job.field, prof_info: Faker::Job.title)
end
40.times do 
    c = Course.create(professor_id: Professor.all.sample.id, semester: ['Fall', 'Spring'].sample, year: Faker::Number.number(digits: 4), course_title: Faker::Job.key_skill, course_description: Faker::Quote.famous_last_words)
end
50.times do
    r = Review.create(user_id: User.all.sample.id, course_id: Course.all.sample.id, title: Faker::Movie.quote, rate_up: Faker::Number.between(from: 1, to: 50), rate_down: Faker::Number.between(from: 1, to: 50))
    course_r = CourseRating.create(review_id: r.id, cat1: Faker::Number.between(from: 1, to: 5), cat2: Faker::Number.between(from: 1, to: 10), cat3: Faker::Number.between(from: 1, to: 10), cat4: Faker::Number.between(from: 1, to: 10), cat5: Faker::Number.between(from: 1, to: 10), content: Faker::Quote.famous_last_words)
    prof_r = ProfessorRating.create(review_id: r.id, cat1: Faker::Number.between(from: 1, to: 5), cat2: Faker::Number.between(from: 1, to: 10), cat3: Faker::Number.between(from: 1, to: 10), cat4: Faker::Number.between(from: 1, to: 10), cat5: Faker::Number.between(from: 1, to: 10), strength: Faker::Quote.famous_last_words, improvement: Faker::Quote.famous_last_words)
end