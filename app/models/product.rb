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
#
class Product < ApplicationRecord

    validates :price, 
        format: {with: /\A\d+(?:\.\d{0,2})?\z/,  message: "must be a decimal with 2 decimal places or less" },
        presence: true
        
    validates :amount, :description, presence: true
    validates :bullet_desc, presence: true
    validates :name, presence: true, uniqueness: true
    validate :bullet_desc_is_array

    def bullet_desc_is_array
        errors.add(:bullet_desc, "must be an array") unless bullet_desc.is_a?(Array)
    end

end
