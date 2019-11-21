class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :stars
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
