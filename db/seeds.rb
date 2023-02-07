

ApplicationRecord.transaction do 
    puts "Destroying tables..."
    # Unnecessary if using `rails db:seed:replant`
    User.destroy_all
    Product.destroy_all
    Category.destroy_all
  
    puts "Resetting primary keys..."
    # For easy testing, so that after seeding, the first `User` has `id` of 1
    ApplicationRecord.connection.reset_pk_sequence!('users')
    ApplicationRecord.connection.reset_pk_sequence!('products')
    ApplicationRecord.connection.reset_pk_sequence!('categories')


# ----------------------------- Users ----------------------------- #
    puts "Creating users..."

    # demo user for demo login
    User.create!(
      name: 'Demo-lition', 
      email: 'demo@user.io', 
      password: 'password'
    )
  
    # More users
    10.times do 
      User.create!({
        name: Faker::Internet.unique.username(specifier: 3),
        email: Faker::Internet.unique.email,
        password: 'password'
      }) 
    end
    
# ----------------------------- Categories ----------------------------- #

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  category   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

    puts "Creating categories"
    
    Category.create!(category: 'leaves')
    Category.create!(category: 'trees')
    Category.create!(category: 'water')
    Category.create!(category: 'fish')
    Category.create!(category: 'cats')
    Category.create!(category: 'dirt')
    Category.create!(category: 'wood')
    Category.create!(category: 'rain')
    
    puts "Done!"
    
    
# ----------------------------- Products ----------------------------- #
    # == Schema Information
    #
    #  Table name: products
    #
    #  name        :string           not null
    #  amount      :integer          not null
    #  price       :decimal(, )      not null
    #  description :text             not null
    #  bullet_desc :text             default([]), not null, is an Array

    puts "Creating products..."

    Product.create!(
      name: 'Big Leaf',
      amount: 200000,
      price: 40.52,
      description: "A really big leaf",
      bullet_desc: ['it is large', 'it is green', "it is drawn by yours truly :)"],
      image: 'amazonLeaf.png',
      category_id: 1
    )
    puts "Done!"
end
