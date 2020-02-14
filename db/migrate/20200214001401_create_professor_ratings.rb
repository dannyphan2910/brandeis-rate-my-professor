class CreateProfessorRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :professor_ratings do |t|
      t.integer :review_id
      t.integer :cat1
      t.integer :cat2
      t.integer :cat3
      t.integer :cat4
      t.integer :cat5
      t.string :strength
      t.string :improvement

      t.timestamps
    end
  end
end
