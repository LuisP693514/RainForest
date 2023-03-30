

ApplicationRecord.transaction do 
    puts "Destroying tables..."
    # Unnecessary if using `rails db:seed:replant`
    Cart.destroy_all
    User.destroy_all
    Product.destroy_all
    Category.destroy_all
    CartItem.destroy_all
    Review.destroy_all
  
    puts "Resetting primary keys..."
    # For easy testing, so that after seeding, the first `User` has `id` of 1
    ApplicationRecord.connection.reset_pk_sequence!('users')
    ApplicationRecord.connection.reset_pk_sequence!('products')
    ApplicationRecord.connection.reset_pk_sequence!('categories')
    ApplicationRecord.connection.reset_pk_sequence!('carts')
    ApplicationRecord.connection.reset_pk_sequence!('cart_items')
    ApplicationRecord.connection.reset_pk_sequence!('reviews')


# ----------------------------- Users ----------------------------- #
    puts "Creating users..."

    # demo user for demo login
    User.create!(
      name: 'Demo User', 
      email: 'demo@user.io', 
      password: 'password'
    )
  
    # More users
    10.times do 
      User.create!({
        name: Faker::Name.unique.name,
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
      description: "Introducing the stunningly large leaf that will captivate your senses and make a bold statement in any setting! This exquisite leaf is truly a marvel of nature, boasting impressive dimensions that are sure to leave you in awe. Measuring in at an impressive size, this leaf is truly a sight to behold, with its rich, verdant hue and intricate veins that lend it a captivating texture and depth. Whether you're looking to add a touch of natural beauty to your home decor or to enhance the visual appeal of your office space, this large leaf is the perfect choice. Its impressive size makes it an ideal focal point, and it can be displayed in a variety of ways to showcase its unique features. From placing it in a decorative vase to mounting it on a wall, this leaf is incredibly versatile and will add a touch of elegance and sophistication to any room. So why settle for ordinary decor when you can elevate your space with this extraordinary leaf? Overall, this large leaf is a must-have for anyone who appreciates the beauty of nature and wants to add a touch of organic elegance to their surroundings. With its impressive size, rich color, and intricate texture, this leaf is truly a work of art that will be the envy of all who behold it. Don't miss your chance to own this stunning piece of nature and enhance the beauty of your home or office today!",
      bullet_desc: ['Impressive size that makes it a standout piece in any setting',
        'Rich, verdant hue that adds a pop of color to your decor',
        "Intricate veins that lend it a captivating texture and depth",
        "Versatile display options, such as placing it in a decorative vase or mounting it on a wall",
        "Natural and organic beauty that brings a touch of the outdoors inside",
        "Durable and long-lasting, requiring minimal maintenance to keep its stunning appearance",
        "Can be used as a focal point or as part of a larger decorative display",
        "Adds a touch of elegance and sophistication to any room",
        "Makes for a unique and thoughtful gift for nature lovers and decor enthusiasts alike"
      ],
      image: 'amazonLeaf.png',
      category_id: 1
    )

    #big leag HD
    Product.create!(
      name: 'Big Leaf HD',
      amount: 200000,
      price: 29.99,
      description: "Behold the breathtaking beauty of this stunning leaf captured in an exquisite photograph that will transport you to the heart of nature's splendor. The striking image showcases the intricate details and vibrant hues of the leaf, from its rich green color to its delicate veins that create a captivating texture. The sheer size of the leaf commands attention and draws the eye to its natural beauty, while the background of the image further emphasizes the leaf's organic elegance. This photograph is not just a piece of art, but a window into the world of nature, inviting you to appreciate its complexity and marvel at its intricacy. It is a statement piece that will add a touch of sophistication to any room, and make for a thoughtful and unique gift for nature lovers and photography enthusiasts alike. Whether you're looking to add a touch of natural beauty to your home or office, or simply want to enhance your collection of art, this photograph is the perfect choice.",
      bullet_desc: [
        "Exquisite photograph capturing the natural beauty of a stunning leaf",
        'Rich green color and intricate veins creating a captivating texture',
        "Large size commanding attention and drawing the eye to its organic elegance", 
        "Background emphasizing the leaf's natural beauty and complexity",
        "A window into the world of nature, inviting appreciation of its intricacy",
        "Sophisticated statement piece adding elegance to any room",
        "Unique and thoughtful gift for nature lovers and photography enthusiasts",
        "Versatile decor option that complements a variety of styles and aesthetics",
        "High-quality print ensuring long-lasting beauty and enjoyment",
        "Captivating image that can spark conversations and inspire contemplation."
      ],
      image: 'amazonLeafHD.png',
      category_id: 1
    )

    #capybara
    Product.create!(
      name: 'Capybara',
      amount: 0,
      price: 200,
      description: "Capybaras, scientifically known as Hydrochoerus hydrochaeris, are the largest rodents in the world, belonging to the family Caviidae. They are native to South America and have a barrel-shaped body with short legs and a small, blunt head. Capybaras have short, rough fur that can range from brown to gray in color, and they have large, expressive eyes and small ears.
      Capybaras have four toes on their front feet and three toes on their hind feet, which are webbed, making them excellent swimmers. They have scent glands on their nose and anus that they use to communicate with other capybaras, marking their territory and social status. Capybaras are herbivores and feed on a variety of grasses, aquatic plants, and fruits.
      Capybaras are social animals and typically live in groups of 10-20 individuals, with a dominant male leading the group. They are semi-aquatic and can hold their breath underwater for up to five minutes. Capybaras are an important prey species for a variety of predators, including jaguars, anacondas, and caimans.
      In terms of conservation, capybaras are classified as \"Least Concern\" by the International Union for Conservation of Nature (IUCN), due to their large population size and widespread distribution throughout South America. However, they are still threatened by habitat loss and hunting for their meat and fur in some regions.",
      bullet_desc: [
        "They have a barrel-shaped body with short legs, webbed feet, and a small head with large, expressive eyes and small ears", 
        "Capybaras have short, rough fur that is usually brown or gray in color, and they have scent glands on their nose and anus that they use to communicate with other capybaras", 
        "They are social animals and typically live in groups of 10-20 individuals, with a dominant male leading the group", 
        'Semi-aquatic and can hold their breath underwater for up to five minutes, making them excellent swimmers.',
        "They are herbivores and primarily feed on grasses, aquatic plants, and fruits.",
        "They are not typically kept as pets and are protected in many countries due to overhunting in the past"
       ],
      image: 'capybara.png',
      category_id: 2
    )

    #jaguar
    Product.create!( 
      name: 'Jaguar - 96 kg (212 lb) - 1.85 m Long (6 ft)',
      amount: 20,
      price: 1000000.00,
      description: "The jaguar, scientifically known as Panthera onca, is a large feline predator found in Central and South America. They are the third-largest cat species in the world after tigers and lions, and are known for their powerful build, strong jaws, and distinctive spotted coat.

      Jaguars have a muscular, compact body with short, stocky legs and a large head with powerful jaws. They have a distinctive coat pattern of black spots on a tawny background, with some individuals having a melanistic (all black) coat. Jaguars have excellent eyesight and are solitary hunters, stalking their prey and using their powerful jaws to deliver a lethal bite to the skull or neck.
      
      Jaguars are found in a variety of habitats, including tropical rainforests, grasslands, and wetlands. They are apex predators and are known to hunt a variety of prey, including deer, peccaries, monkeys, birds, and fish. They are also strong swimmers and have been known to hunt and kill caimans in the water.
      
      In terms of conservation, jaguars are classified as \"Near Threatened\" by the International Union for Conservation of Nature (IUCN) due to habitat loss, fragmentation, and hunting. They are protected in many countries, but populations are still declining in some areas. Conservation efforts are focused on protecting and connecting habitat corridors and reducing human-jaguar conflict.",
      bullet_desc: [
        'Third-largest cat species in the world after tigers and lions', 
        'Muscular, compact body with short, stocky legs', 
        'Large head with powerful jaws', 
        'Distinctive coat pattern of black spots on a tawny background, with some individuals having a melanistic (all black) coat', 
        'Excellent eyesight and powerful jaws for delivering a lethal bite to the skull or neck of prey',
        "Strong swimmers and capable of hunting and killing caimans in the water",
        "Apex predators known to hunt a variety of prey, including deer, peccaries, monkeys, birds, and fish",
      ],
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
      description: "Introducing our premium bug spray - the perfect solution for keeping pesky insects at bay. Our formula is specially designed to repel a wide range of insects, including mosquitoes, flies, ticks, and more. It's easy to use and can be applied directly to the skin or clothing for maximum protection.
      Our bug spray is made with high-quality, all-natural ingredients that are safe for both adults and children. It contains a blend of essential oils, including citronella, lavender, and peppermint, which are known for their natural insect-repelling properties. Our formula is also free from harsh chemicals and artificial fragrances, making it a safe and eco-friendly choice.
      Not only does our bug spray keep insects away, but it also has a pleasant, refreshing scent that you'll love. It's perfect for outdoor activities like camping, hiking, and picnics, and can also be used indoors to keep bugs out of your home.
      With our bug spray, you can enjoy the great outdoors without worrying about pesky insects. It's the perfect addition to your outdoor gear and a must-have for anyone who loves spending time outside. Try it today and experience the difference for yourself!",
      bullet_desc: [
        'Repels a wide range of insects, including mosquitoes, flies, ticks, and more', 
        'Made with high-quality, all-natural ingredients that are safe for both adults and children', 
        'Contains a blend of essential oils, including citronella, lavender, and peppermint, known for their natural insect-repelling properties', 
        'Free from harsh chemicals and artificial fragrances, making it a safe and eco-friendly choice', 
        'Easy to use and can be applied directly to the skin or clothing for maximum protection',
        "Pleasant and refreshing scent, making it perfect for outdoor activities like camping, hiking, and picnics",
        "Can also be used indoors to keep bugs out of your home",
        "Allows you to enjoy the great outdoors without worrying about pesky insects",
        "A must-have for anyone who loves spending time outside"
      ],
      image: 'bugSpray.png',
      category_id: 4
    )

    #cast iron
    Product.create!(
      name: 'Cast Iron - Heavy Duty - 56 ft. diameter - Large Cast Iron',
      amount: 200000,
      price: 56.56,
      description: "Imagine standing before a colossal cast iron product, measuring a remarkable 56 feet in diameter. The sheer size and weight of this product would be awe-inspiring, and it would undoubtedly leave a lasting impression on anyone who saw it.
      As you approach the product, you can feel the heat emanating from its surface, a testament to its exceptional thermal conductivity. Despite its size, the product is beautifully detailed, with intricate designs etched into the cast iron surface. The level of attention to detail is remarkable, and it's clear that a great deal of skill and craftsmanship went into its creation.
      It's hard to imagine anything of this size and magnitude existing in reality, but the beauty of this cast iron product is that it transcends our normal expectations and limitations. It's a testament to the power of human creativity and imagination, and it stands as a symbol of the limitless potential of our minds. Whether used as a functional element in a large-scale construction project or as an art installation, this cast iron product would be an unforgettable addition to any space.",
      bullet_desc: [
        'Unique and eye-catching centerpiece: A 56-foot diameter cast iron product would be a show-stopping centerpiece in any setting. Whether used as an art installation, a conversation starter, or a functional element in a large-scale construction project, this product is sure to capture attention.', 
        'High-quality and durable material: Cast iron is known for its strength and durability, and a product of this size would be no exception. Made from high-quality materials and designed to withstand the test of time, this product would be a long-lasting investment that will continue to impress for generations to come.', 
        'Versatile uses: Depending on the specific design and construction of the product, it could have a wide range of potential uses. It could serve as the base of a large sculpture or fountain, the centerpiece of a public plaza or park, or even as a structural element in a building or bridge. The possibilities are endless!', 
        'Customizable design: With a product of this size, there would be plenty of room for customization and personalization. The design could be tailored to fit the specific needs and aesthetic preferences of the buyer, making it a truly one-of-a-kind creation.', 
        'Symbolic value: A 56-foot diameter cast iron product could hold symbolic value for a community or organization, representing strength, unity, and permanence. Whether used in a public space or in a private collection, this product would be a powerful symbol of resilience and longevity.', 
        'Image is not to scale.'
      ],
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
      bullet_desc: ['Can chop trees', 'Gather that wood around the forest', 'Proven to work on any tree of any size.', 'REAL STEEL (not fake)'],
      image: 'hatchet.png',
      category_id: 3
    )

    #squirrelMonkey
    Product.create!(
      name: 'Squirrel Monkey - Very Cute & Tiny - 963g (2.12 lbs) - 310mm Tall (1 ft.)' ,
      amount: 300000,
      price: 963212.31,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Super cute', 'Will take your cookie', 'TINY: their small size are proven expand on their cuteness ', 'Can be trained to be annoying'],
      image: 'squirrelMonkey.png',
      category_id: 2
    )

    #giant catfish
    Product.create!(
      name: 'Arapaima Gigas - Large Catfish - 100 kg (220 lb) - 3 m Long (9.8 ft)' ,
      amount: 5,
      price: 100220.98,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ex ante. Donec enim mi, ullamcorper vel tortor sit amet, iaculis congue odio. Pellentesque dignissim finibus viverra. Sed maximus sem nec arcu interdum, eget gravida felis molestie. Nulla id vulputate sapien. Suspendisse rutrum pellentesque sapien non pulvinar. Mauris elit eros, fringilla a interdum at, hendrerit viverra neque. Curabitur dictum felis nec sem finibus aliquet. In nec lectus eu sapien auctor mattis non commodo mi. \n \n Phasellus dignissim mauris a velit malesuada tincidunt. Sed maximus at mi nec tempor. Integer gravida nec erat sed molestie. Donec sed congue nibh. Suspendisse non tortor eget magna pellentesque bibendum. Cras placerat elit arcu, sed sagittis metus venenatis ut. Aliquam porttitor gravida ligula lobortis molestie. Pellentesque non lectus sed augue feugiat condimentum. Mauris pulvinar nulla magna, eget scelerisque est tempor sed.",
      bullet_desc: ['Can breathe air!', 'Thrives in oxygen-deprived waters like the Amazon River', 'Eats fruits, insects, seeds, and small land animals', 'The TOP predetor in oxbow lakes! (During low water season)', 'IMAGE: By Shizhao - Own work, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=7755863', 'Learn more at https://en.wikipedia.org/wiki/Arapaima'],
      image: 'giantCatfish.jpg',
      category_id: 6
    ) 

# ----------------------------- Reviews ----------------------------- #
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

  puts "Generating reviews..."

  #Big leaf reviews (product_id: 1)
    Review.create!(
      body: "I recently purchased the large leaf and I am absolutely thrilled with my purchase! The leaf is even more impressive in person, with its vibrant green color and intricate veins creating a texture that is simply breathtaking. The size of the leaf is truly impressive and adds a touch of natural beauty to my home that I didn't even realize was missing until I added it.

      \n\nWhat I love most about the leaf is its versatility. It can be displayed in a variety of ways, from placing it in a decorative vase to mounting it on a wall, which makes it perfect for anyone looking for unique and creative ways to enhance their decor. The leaf is also incredibly durable and long-lasting, requiring minimal maintenance to keep its beauty intact.",
      product_id: 1,
      score: 4,
      user_id: 2
    )

    Review.create!(
      body: "I recently purchased the large leaf and I have to say, I am disappointed with my purchase. While the size of the leaf is certainly impressive, the overall quality of the product is underwhelming. The color of the leaf is not as rich as I had hoped and the texture is not as intricate as I was expecting. In fact, the veins are barely noticeable, which takes away from the natural beauty of the leaf.

      \n\nAdditionally, the leaf was difficult to display in a way that looked good. It kept drooping and looked awkward no matter how I tried to position it. I was disappointed with the price of the leaf. Given the lack of quality and versatility, I feel that the price point is simply too high. I would not recommend this product to anyone looking for a beautiful and unique addition to their decor, as I feel there are much better options available at a lower cost.",
      product_id: 1,
      score: 1,
      user_id: 4
    )

    Review.create!(
      body: "I recently purchased the large leaf and while it is certainly a beautiful piece, I can't help feeling a bit sad about my purchase. Unfortunately, the leaf arrived with a few small tears along the edges, which took away from its natural beauty. I was looking forward to displaying it in a prominent spot in my home, but now I'm not sure if I want to showcase it at all.

      \n\nOn top of that, the size of the leaf is almost too large for my home, which has made it difficult to find the perfect spot for it. I feel like I wasted my money on a product that I can't even fully enjoy or appreciate. Overall, I'm just disappointed that my purchase didn't live up to my expectations.",
      product_id: 1,
      score: 1,
      user_id: 7
    )

  #Big leaf HD reviews (product_id: 2)
    Review.create!(
      body: "Now this is what I'm talking about! A real leaf!!!",
      product_id: 2,
      score: 5,
      user_id: 4
    )

  puts "Done!"
end
