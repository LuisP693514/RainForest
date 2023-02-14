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
class CartItem < ApplicationRecord

    validates :quantity, presence: true

    belongs_to :cart,
        foreign_key: :cart_id,
        class_name: :Cart

    belongs_to :product,
        foreign_key: :product_id,
        class_name: :Product
end
