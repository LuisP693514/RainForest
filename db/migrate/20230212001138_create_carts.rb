class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.references :user, null: true, foreign_key: true
      t.string :session, null: false
      t.timestamps
    end

    add_index :carts, :session, unique: true
  end
end