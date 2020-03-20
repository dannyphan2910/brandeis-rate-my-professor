class CreateReviewForms < ActiveRecord::Migration[6.0]
  def change
    create_table :review_forms do |t|
      t.references :review

      t.timestamps
    end
  end
end
