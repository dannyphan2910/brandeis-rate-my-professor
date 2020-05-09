class CreatePreferences < ActiveRecord::Migration[6.0]
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.boolean :likes_participation
      t.boolean :likes_workload
      t.boolean :likes_testing

      t.timestamps
    end
  end
end
