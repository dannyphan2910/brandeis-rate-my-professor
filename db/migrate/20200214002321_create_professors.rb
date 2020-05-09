class CreateProfessors < ActiveRecord::Migration[6.0]
  def change
    create_table :professors do |t|
      t.string :prof_first_name
      t.string :prof_last_name
      t.string :prof_email
      t.integer :department_id
      t.string :prof_info

      t.timestamps
    end
  end
end
