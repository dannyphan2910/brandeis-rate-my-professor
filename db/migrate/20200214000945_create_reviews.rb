class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :professor_id
      t.string :title
      t.integer :rate_up
      t.integer :rate_down

      t.timestamps
    end
  end
end
