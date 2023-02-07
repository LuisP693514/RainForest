class UpdateProductsTableForTheLastTime < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :image, :string, null: false, default: ''
  end
end
