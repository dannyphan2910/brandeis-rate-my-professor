class CreateCourseRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :course_ratings do |t|
      t.integer :review_id
      t.integer :cat1
      t.integer :cat2
      t.integer :cat3
      t.integer :cat4
      t.integer :cat5
      t.string :content

      t.timestamps
    end
  end
end
