

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
    
# ----------------------------- Categories --------------------------- #
    #
    # == Schema Information
    #
    # Table name: categories
    #
    #  id         :bigint           not null, primary key
    #  category   :string           not null
    #  created_at :datetime         not null
    #  updated_at :datetime         not null


    puts "Creating categories"
    
    Category.create!(category: 'Leaves') #1
    Category.create!(category: 'Animals') #2
    Category.create!(category: 'Camping') #3
    Category.create!(category: 'Tools') #4
    Category.create!(category: 'Clothing') #5
    Category.create!(category: 'Fish') #6
    Category.create!(category: 'Wood') #7
    Category.create!(category: 'Vehicles') #8

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
    #  image       :string           default(""), not null
    #  category_id :bigint           not null

    puts "Creating products..."

    #big leaf
    Product.create!(
      name: 'Big Leaf',
      amount: 200000,
      price: 40.52,
      description: "A really big leaf",
      bullet_desc: ['It is large', 'It is green', "It is drawn by yours truly :)"],
      image: 'amazonLeaf.png',
      category_id: 1
    )

    #big leag HD
    Product.create!(
      name: 'Big Leaf HD',
      amount: 200000,
      price: 29.99,
      description: "A really big leaf in High Definition. Dimensions may vary",
      bullet_desc: ['It is large', 'It is green', "It is taken with a real camera", "Can't go wrong with a large green HD leaf"],
      image: 'amazonLeafHD.png',
      category_id: 1
    )

    #tiger
    Product.create!(
      name: 'Tigers',
      amount: 10,
      price: 40000.00,
      description: "They will kill the rats around the house. Careful with the dog!",
      bullet_desc: ['They have big teeth', 'Occasionally angry', "Loves eating fish!"],
      image: 'tigers.jpg',
      category_id: 2
    )

    #jaguar
    Product.create!( 
      name: 'Jaguar',
      amount: 20,
      price: 1000000.00,
      description: "Super predetor Jaguar. Will hunt other predators for you! Who knows, it might see you as a threat, so be careful when purchasing. ",
      bullet_desc: ['Near threatened species (close to extinction)', 'Super predator'],
      image: 'jaguar.png',
      category_id: 2
    )

    #janira beanie
    Product.create!(
      name: 'Silk Reine Mulberry Silk Lined Beanie (Unisex) – Black Knitted Hat with Pure Silk Lining – Warm – Soft & Slouchy/Suitable for All Seasons – Giftable Beanie for Men & Women',
      amount: 20000,
      price: 34.99,
      description: "SILK REINE Mulberry Silk-Lined Knitted Beanie (Black) Say goodbye to beanies that cause bad hair days. There’s no need to worry about knots or frizz when wearing our stylish silk-lined beanie hat — designed to eliminate hat hair and keep your locks healthy! Crafted from knitted acrylic for a warm and cozy feel, the interior of this hat is lined with breathable, temperature-regulating silk. Wear this stylish slouch beanie all day long and it won’t irritate the scalp thanks to its hypoallergenic properties. You can even use it as a silk bonnet while you sleep if you want to protect your hair from drying cotton pillowcases. Unlike standard satin-lined beanies, this accessory is made with mulberry silk: the highest quality silk available on the market. Its supremely soft texture prevents friction against your scalp and strands — aiding in the prevention of hair loss and breakage. Silk also won’t strip away any moisture, allowing your flowing locks to retain their healthy, natural shine. Care instructions: hand-washing and leaving this accessory to air dry is recommended. The materials are resistant to fading and shrinkage.", 
      bullet_desc: [
        'Outer layer: 100% Acrylic, Inner Lining: 100% Mulberry Silk',
        'Imported',
        'Pull On closure',
        'Hand Wash Only',
        'STYLISH SILK-LINED BEANIE: Upgrade your everyday wear with this trendy knitted beanie, which is lined with silk to protect your scalp and tame messy hat hair. Crafted with comfort in mind, this hat is suitable for both hot and cold days due to its temperature-regulating features.',
        'MULBERRY SILK LINING: Unlike standard satin beanies, our lined slouch beanie incorporates Mulberry silk for maximum quality and long-lasting wear. The finest silk available, this material has a supremely soft texture and is hypoallergenic to prevent any scalp irritation.',
        'HELPS HAIR MAINTAIN SHINE: Materials like cotton strip away moisture from your strands, leading to dry and damaged locks. Silk headwear can be worn all day long (or while you sleep as a bonnet), as it doesn’t absorb the hair’s natural oils and therefore retains a healthy shine.',
        'PREVENTS KNOTS & FRIZZ: Keep your curls under control and locks frizz-free with this lined slouchy beanie for women. There is no need to worry about knots, tangles, or breakage, as silk is extremely smooth and does not cause friction. It may also aid in the prevention of hair loss.',
        'ONE-SIZE-FITS-ALL: Carefully crafted from knitted acrylic, this hat is lined with stretchy elastic to offer maximum comfort without falling off easily. In order to maintain its pristine quality, we advise only hand-washing your lined beanie and letting it air dry to avoid shrinkage and fading.'
        ],
      image: 'janiraHat.png',
      category_id: 5
    )

    #bug spray
    Product.create!(
      name: 'Really Good Bug Spray - Outdoors - Camping Trip Bug Spray - Very Good Long Name',
      amount: 0,
      price: 2.89,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Great for outdoors!', 'Kill those bugs!', 'Is that a cockaroach in your pocket?', 'Extremely effective, 99.9% of bug spray owners recommend!', 'It even works on rats!'],
      image: 'bugSpray.png',
      category_id: 4
    )

    #cast iron
    Product.create!(
      name: 'Cast Iron - Heavy Duty - 56 ft. radius - Large Cast Iron',
      amount: 200000,
      price: 56.56,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Great for outdoors!', 'Can cook enough food for a section of the forest', 'Can keep food cooked for hours', 'Will not burn your food!', 'Doubles as a giant arena!', 'Image is not to scale'],
      image: 'castIron.png',
      category_id: 4
    )

    #charcoal
    Product.create!(
      name: 'Charcoal - Fire fuel - 200lbs of Cooking Rocks - 100hr lifetime',
      amount: 300000,
      price: 13.29,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Charcoal used for camping, cookouts, bonfires, train fuel', 'Can last as long as 100hrs', 'With 200lbs you can\'t go wrong!', 'Extremely effective, 99.9% of charcoal owners recommend!', 'Bring your friends to the cookout!'],
      image: 'charcoal.png',
      category_id: 3
    )

    #charcoalFuel
    Product.create!(
      name: 'Charcoal Liquid Fuel - Keeps the Fire Going - 3KL Pure Diesel' ,
      amount: 300000,
      price: 132.00,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Each milliliter of this fuel can keep a fire going for 12 hours.', 'Sealed container prevents leaks', 'Water proof caps so that you can use it in the rain!', '100% real diesel!', 'It even doubles as car fuel'],
      image: 'charcoalFuel.png',
      category_id: 3
    )

    #hatchet
    Product.create!(
      name: 'Hatchet - Not the Book - Stainless Steel - Heavy Duty' ,
      amount: 300000,
      price: 34.95,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Can chop trees', 'Gather that wood around the forest', 'Proven to work on any tree of any size.', 'REAL STEEL (not fake)', ''],
      image: 'charcoalFuel.png',
      category_id: 3
    )

    puts "Done!"
end
