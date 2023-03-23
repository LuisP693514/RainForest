# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  body       :string
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  score      :integer          default(5), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Review < ApplicationRecord

    belongs_to :user,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :product,
        foreign_key: :product_id,
        class_name: :Product

    validates :body,
        length: {in: 0..1000},
        allow_nil: true
end
