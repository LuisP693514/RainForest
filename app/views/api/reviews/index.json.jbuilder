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

@reviews.each do |review|
    json.set! review.id do
        json.extract! review, :id, :body, :user_id, :product_id, :score
    end
end

json.reviews_ids @reviews.pluck(:id)