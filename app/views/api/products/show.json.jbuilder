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
#  category    :string           default(""), not null

json.product do
    json.extract! @product, :id, :name, :price, :amount, :description, :bullet_desc, :image, :category
  end