class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :ammount, null: false
      t.decimal :price, null: false
      t.text :description, null: false
      t.text :bullet_desc, null: false, array: true, default: []

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
