# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  amount      :integer          not null
#  price       :decimal(, )      not null
#  description :text             not null
#  bullet_desc :text             default([]), not null, is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string           default(""), not null
#  category_id :bigint           not null
#
class Product < ApplicationRecord

    validates :price, 
        format: {with: /\A\d+(?:\.\d{0,2})?\z/,  message: "must be a decimal with 2 decimal places or less" },
        presence: true
        
    validates :amount, :description, :bullet_desc, :category_id, presence: true
    validates :name, presence: true, uniqueness: true
    validate :bullet_desc_is_array
    validate :image_not_empty

    def image_not_empty
        errors.add(:image, 'must have image') unless image.length > 0
    end

    def bullet_desc_is_array
        errors.add(:bullet_desc, "must be an array") unless bullet_desc.is_a?(Array)
    end

    belongs_to :category,
        foreign_key: :category_id,
        class_name: :Category

end
