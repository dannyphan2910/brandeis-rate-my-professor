class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.integer :course_id
      t.string :title
      t.integer :rate_up
      t.integer :rate_down

      t.timestamps
    end
    add_index :reviews, [:user_id, :course_id, :created_at]
  end
end
