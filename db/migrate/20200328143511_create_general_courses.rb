class CreateGeneralCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :general_courses do |t|
      t.string :course_code
      t.string :course_title
      t.string :course_description

      t.timestamps
    end
  end
end
