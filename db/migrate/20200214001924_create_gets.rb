class CreateGets < ActiveRecord::Migration[6.0]
  def change
    create_table :gets do |t|
      t.integer :course_id
      t.integer :review_id

      t.timestamps
    end
  end
end
