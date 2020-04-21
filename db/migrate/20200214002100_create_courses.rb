class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :professor_id
      t.string :semester
      t.integer :year
      t.integer :general_course_id

      t.timestamps
    end
  end
end
