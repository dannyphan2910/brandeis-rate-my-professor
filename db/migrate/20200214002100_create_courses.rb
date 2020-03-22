class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :professor_id
      t.string :semester
      t.integer :year
      t.string :course_code
      t.string :course_title
      t.string :course_description

      t.timestamps
    end
  end
end
