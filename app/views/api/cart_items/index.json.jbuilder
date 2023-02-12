# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  cart_id    :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

@cart_items.each do |cart_item|
    json.set! cart_item.id do
        json.extract! cart_item, :id, :product_id, :cart_id, :quantity
    end
end

json.category_Ids @cart_items.pluck(:id)