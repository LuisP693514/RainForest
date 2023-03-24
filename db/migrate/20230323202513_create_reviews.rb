class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|

      t.string :body
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :score, null: false, default: 5

      t.timestamps
    end
  end
end
