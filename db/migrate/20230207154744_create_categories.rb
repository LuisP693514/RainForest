class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :category, null: false, unique: true
      t.timestamps
    end

    add_index :categories, :category
  end
end
