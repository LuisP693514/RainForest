class ChangeProductColumnAmmountToAmount < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :ammount, :amount
  end
end
