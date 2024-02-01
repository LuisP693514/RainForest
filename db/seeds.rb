

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

    #big leaf 1
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

    #big leag HD 2
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

    #capybara 3
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

    #jaguar 4
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

    #janira beanie 5
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

    #bug spray 6
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

    #cast iron 7
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

    #charcoal 8 
    Product.create!(
      name: 'Charcoal - Fire fuel - 200lbs of Cooking Rocks - 100hr lifetime',
      amount: 300000,
      price: 13.29,
      description: "200lbs of high-quality charcoal are the perfect addition to any outdoor cooking experience. With a long lifetime, you can rest assured that these charcoal briquettes will last through multiple grilling sessions, providing consistent and even heat every time.

      Our charcoal is made from high-quality materials and is carefully crafted to provide the perfect balance of heat and burn time. Whether you're cooking up a quick meal or planning a long, slow smoke, our charcoal will deliver the perfect flavor every time.
      
      Unlike other brands, our charcoal is designed to burn clean, without producing any harmful chemicals or byproducts. This means you can cook with confidence, knowing that you're not only getting great flavor but also taking care of your health and the environment.
      
      Our 200lbs of charcoal are perfect for backyard barbecues, camping trips, or any outdoor cooking adventure. With our long-lasting charcoal, you can enjoy more time cooking and less time worrying about refueling.",
      bullet_desc: [
        "Long lifetime: Our 200lbs of charcoal have a really long lifetime, meaning they'll last through multiple grilling sessions",
        "High-quality materials: Our charcoal is made from high-quality materials and crafted to provide the perfect balance of heat and burn time.",
        "Consistent and even heat: Our charcoal briquettes deliver consistent and even heat every time you use them, so you can cook with confidence.", 
        "Clean-burning: Unlike other brands, our charcoal burns clean without producing any harmful chemicals or byproducts.", 
        "Great flavor: Our charcoal is designed to provide the perfect flavor to your grilled foods, making your outdoor cooking experience even more enjoyable.",
        "Perfect for any occasion: Our 200lbs of charcoal are ideal for backyard barbecues, camping trips, or any outdoor cooking adventure.",
        "Saves time: With our long-lasting charcoal, you can enjoy more time cooking and less time worrying about refueling."
      ],
      image: 'charcoal.png',
      category_id: 3
    )

    #charcoalFuel 9
    Product.create!(
      name: 'Extreme Heat Charcoal: The Ultimate High-Performance Fuel for Outdoor Cooking' ,
      amount: 300000,
      price: 132.00,
      description: "Premium line of high-performance charcoal, specifically designed to provide you with the most intense and sustained heat possible! Our charcoal fuel is the ultimate choice for outdoor cooking enthusiasts who demand nothing but the best.

      Crafted from carefully selected materials and formulated to maximize burn time, our charcoal will deliver a heat output that rivals even the most powerful fuels on the market. You'll be amazed at how quickly and efficiently our charcoal cooks your food, saving you time and hassle while producing delicious, flavorful meals.
      
      Our high-performance charcoal is perfect for all kinds of outdoor cooking adventures, from backyard barbecues to camping trips and beyond. Whether you're cooking up burgers and hot dogs or preparing a slow-smoked brisket, our charcoal will deliver the intense, sustained heat you need to achieve perfect results every time.",
      bullet_desc: [
        "Intense heat output: Our charcoal fuel delivers an intense and sustained heat output that rivals even the most powerful fuels on the market.", 
        "Maximum burn time: Formulated to maximize burn time, our charcoal provides longer cooking sessions without the need for refueling.", 
        "Faster and more efficient cooking: With our high-performance charcoal, you can cook your food faster and more efficiently, saving you time and hassle while producing delicious, flavorful meals.", 
        "Perfect for all kinds of outdoor cooking: Our charcoal is ideal for all kinds of outdoor cooking adventures, from backyard barbecues to camping trips and beyond.", 
        "Great for slow-smoking: Our charcoal is perfect for slow-smoking meats, delivering the sustained heat needed to achieve perfect results every time.",
        "High-quality materials: Crafted from carefully selected materials, our charcoal is formulated to provide the ultimate in heat output and burn time.",
        "Exceptional flavor: Our charcoal delivers exceptional flavor to your food, enhancing the natural flavors of your ingredients and taking your outdoor cooking to the next level.",
        "Convenient and easy to use: Our charcoal is easy to light and use, making it convenient for all your outdoor cooking needs."
      ],
      image: 'charcoalFuel.png',
      category_id: 3
    )

    #hatchet 10
    Product.create!(
      name: 'Hatchet - Not the Book - Stainless Steel - Heavy Duty' ,
      amount: 300000,
      price: 34.95,
      description: "The perfect tool for all your outdoor adventures! Whether you're camping, hiking, or exploring the great outdoors, a hatchet is an essential tool that can help you with everything from chopping firewood to clearing brush and building shelter.

      Crafted from the highest-quality materials, our hatchets are designed for maximum durability and performance. With a sharp, finely-honed blade and a sturdy handle, our hatchets are both powerful and easy to use, allowing you to tackle even the toughest outdoor tasks with ease.
      
      In addition to their practical uses, our hatchets are also a beautiful and timeless addition to any outdoor enthusiast's collection. With their sleek design and classic style, our hatchets are a true symbol of rugged outdoor living and adventure.",
      bullet_desc: [
        "High-quality materials: Crafted from the highest-quality materials, our hatchets are designed for maximum durability and performance.", 
        "Sharp blade: Our hatchets feature a sharp, finely-honed blade that can easily handle even the toughest outdoor tasks.", 
        "Sturdy handle: With a sturdy handle that provides a comfortable and secure grip, our hatchets are both powerful and easy to use.", 
        "Versatile tool: Our hatchets are a versatile tool that can help with everything from chopping firewood to clearing brush and building shelter.",
        "Sleek design: Our hatchets feature a sleek design and classic style that make them a beautiful and timeless addition to any outdoor enthusiast's collection.",
        "Lightweight and portable: Our hatchets are lightweight and portable, making them easy to carry with you on any outdoor adventure.",
        "Ideal for camping and hiking: Our hatchets are the perfect tool for camping and hiking, allowing you to easily tackle any outdoor task that comes your way.",
        "Perfect for chopping wood: Whether you're starting a fire or building a shelter, our hatchets are ideal for chopping wood and making kindling.",
        "Durable and long-lasting: With their high-quality materials and expert craftsmanship, our hatchets are built to last and provide reliable performance for years to come."
      ],
      image: 'hatchet.png',
      category_id: 4
    )

    #squirrelMonkey 11
    Product.create!(
      name: 'Squirrel Monkey - Very Cute & Tiny - 963g (2.12 lbs) - 310mm Tall (1 ft.)' ,
      amount: 300000,
      price: 963212.31,
      description: "Squirrel monkeys (Saimiri spp.) are small, arboreal primates belonging to the family Cebidae. They are native to the tropical forests of Central and South America and are known for their high level of activity and social behavior.

      Squirrel monkeys have a distinctive appearance, characterized by their small size, long and slender limbs, and short, dense fur that is typically gray or brown in color. They have a white or cream-colored face with black markings around the eyes, and a long, pointed snout.
      
      Their average body length ranges from 25-35 cm, with a tail length of 35-42 cm, and they typically weigh between 0.5-1.5 kg. Squirrel monkeys have excellent vision and are able to see in color, which is an adaptation for their fruit-based diet.
      
      Squirrel monkeys are highly social animals and live in groups of up to 40 individuals, with a dominant male leading the group. They communicate with each other using a variety of vocalizations and body language, and spend much of their time grooming each other to maintain social bonds.
      
      In the wild, squirrel monkeys feed primarily on fruit, but also eat insects, small vertebrates, and other plant material. They are important seed dispersers and play a key role in maintaining the health and diversity of tropical forest ecosystems.
      
      Overall, squirrel monkeys are fascinating and important members of the primate community, known for their social behavior, high level of activity, and important ecological role in their native habitat.",
      bullet_desc: [
        "Arboreal primates: Squirrel monkeys are small, arboreal primates that live in the trees of tropical forests in Central and South America.", 
        "High level of activity: Squirrel monkeys are known for their high level of activity, spending much of their day moving through the trees in search of food and socializing with their group.", 
        "Social behavior: Squirrel monkeys live in large groups of up to 40 individuals and are highly social, communicating with each other using a variety of vocalizations and body language.", 
        "Fruit-based diet: Squirrel monkeys primarily feed on fruit, but also eat insects, small vertebrates, and other plant material.",
        "Excellent vision: Squirrel monkeys have excellent color vision, which is an adaptation for their fruit-based diet.",
        "Important seed dispersers: Squirrel monkeys play a key role in maintaining the health and diversity of tropical forest ecosystems by dispersing seeds of the fruit they eat.",
        "Unique appearance: Squirrel monkeys have a distinctive appearance, characterized by their small size, long and slender limbs, and short, dense fur that is typically gray or brown in color.",
        "Long lifespan: Squirrel monkeys have a relatively long lifespan for their size, living up to 15 years in the wild and up to 20 years in captivity.",
        "Endangered species: Several species of squirrel monkeys are listed as endangered or threatened due to habitat loss and hunting for the pet trade."
      ],
      image: 'squirrelMonkey.png',
      category_id: 2
    )

    #giant catfish 12
    Product.create!(
      name: 'Arapaima Gigas - Large Catfish - 100 kg (220 lb) - 3 m Long (9.8 ft)' ,
      amount: 5,
      price: 100220.98,
      description: "Arapaima gigas, also known as pirarucu, is a species of freshwater fish native to the Amazon Basin in South America. It is the largest freshwater fish in the region and is highly valued for its meat and as a sport fish.

      Arapaima gigas can grow up to 3 meters in length and weigh over 200 kg, making it one of the largest freshwater fish in the world. It has a long, streamlined body with large scales that can be over 15 cm in diameter, providing protection against predators.
      
      This species has a primitive lung that allows it to breathe air, which is an adaptation for the oxygen-poor waters of the Amazon Basin. It is also known for its powerful jaws and sharp teeth, which are used to catch prey such as fish, crustaceans, and even birds.
      
      Arapaima gigas is a slow-growing fish, with some individuals living over 20 years in the wild. It is a highly valued food fish and is also popular with sport fishermen due to its large size and strength.
      
      This species is threatened by overfishing and habitat destruction, and is listed as a vulnerable species by the International Union for Conservation of Nature (IUCN). Efforts are underway to promote sustainable fishing practices and protect the habitats of Arapaima gigas and other Amazonian fish species.",
      bullet_desc: [
        "Largest freshwater fish in the Amazon Basin: Arapaima gigas can grow up to 3 meters in length and weigh over 200 kg, making it one of the largest freshwater fish in the world.", 
        "Highly valued for its meat: Arapaima gigas is a highly valued food fish in South America, known for its flavorful meat.", 
        "Adaptations for oxygen-poor waters: Arapaima gigas has a primitive lung that allows it to breathe air, which is an adaptation for the oxygen-poor waters of the Amazon Basin.", 
        "Powerful jaws and sharp teeth: Arapaima gigas has powerful jaws and sharp teeth, which are used to catch prey such as fish, crustaceans, and even birds.", 
        "Slow-growing: Arapaima gigas is a slow-growing fish, with some individuals living over 20 years in the wild.",
        "Threatened species: Arapaima gigas is listed as a vulnerable species by the IUCN due to overfishing and habitat destruction.",
        "Popular with sport fishermen: Arapaima gigas is popular with sport fishermen due to its large size and strength",
        "Important part of Amazonian ecosystems: Arapaima gigas and other Amazonian fish species play an important role in maintaining the health and diversity of tropical freshwater ecosystems.",
        "Sustainable fishing practices: Efforts are underway to promote sustainable fishing practices and protect the habitats of Arapaima gigas and other Amazonian fish species.",
        'IMAGE: By Shizhao - Own work, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=7755863', 
        'Learn more at https://en.wikipedia.org/wiki/Arapaima'],
      image: 'giantCatfish.jpg',
      category_id: 6
    ) 

    #rosewood 13
    Product.create!(
      name: 'Brazilian Rosewood (Dalbergia nigra)' ,
      amount: 30000,
      price: 999.99,
      description: "Dalbergia nigra, commonly known as Brazilian Rosewood, is a tropical hardwood tree species native to Brazil. It belongs to the Fabaceae family and is known for its high-quality timber, which has been used for centuries in the construction of fine furniture, musical instruments, and decorative objects.

      Brazilian Rosewood can grow up to 30 meters in height and has a trunk diameter of up to 1 meter. The bark is dark brown and rough, with vertical fissures. The leaves are compound and pinnate, with 5-9 leaflets that are oblong or oval in shape and have a glossy appearance. The flowers are small, white, and fragrant, and are arranged in clusters. The fruit is a legume that is flattened, oblong, and contains 1-2 seeds.
      
      The wood of Brazilian Rosewood is prized for its unique reddish-brown color and distinctive grain pattern, which features dark streaks and flecks. It is also known for its hardness, durability, and resonance, which make it a popular choice for musical instruments such as guitars, pianos, and violins. Due to its high demand and slow growth rate, Brazilian Rosewood has become rare and endangered in the wild, and international trade is strictly regulated by CITES to prevent further depletion of the species.",
      bullet_desc: [
        "Native to Brazil", 
        "Belongs to the Fabaceae family", 
        "Can grow up to 30 meters in height with a trunk diameter of up to 1 meter", 
        "Bark is dark brown and rough with vertical fissures", 
        "Leaves are compound and pinnate with 5-9 leaflets",
        "Flowers are small, white, and fragrant and are arranged in clusters",
        "Fruit is a legume that is flattened, oblong, and contains 1-2 seeds",
        "Wood has a unique reddish-brown color and distinctive grain pattern with dark streaks and flecks",
        "Known for its hardness, durability, and resonance",
        'Popular choice for musical instruments such as guitars, pianos, and violins', 
        "Has become rare and endangered in the wild",
        "International trade is strictly regulated by CITES to prevent further depletion of the species."
      ],
      image: 'rosewood.png',
      category_id: 7
    )

    #ipe 14
    Product.create!(
      name: 'Ipe (Tabebuia spp.)' ,
      amount: 30000,
      price: 999.99,
      description: "Tabebuia spp., commonly known as Ipe, is a group of flowering tree species native to Central and South America. It belongs to the Bignoniaceae family and is known for its dense, durable wood that is prized for outdoor construction and decking.

      Ipe trees can grow up to 45 meters in height and have a trunk diameter of up to 2 meters. The bark is gray and smooth, with shallow fissures. The leaves are deciduous and pinnate, with 5-7 leaflets that are elliptical in shape and have a glossy appearance. The flowers are tubular and trumpet-shaped, and range in color from yellow to pink and purple. The fruit is a woody capsule that contains numerous small seeds.
      
      The wood of Ipe is extremely dense, hard, and resistant to decay, insects, and weathering, making it ideal for outdoor applications such as decking, siding, and fencing. It has a dark brown to olive-green color and a fine, straight grain pattern that is sometimes interlocked or irregular. Due to its durability and resistance to rot, Ipe wood has been used for centuries in the construction of docks, bridges, and other marine structures.
      
      Ipe is a slow-growing tree and is often harvested from managed forests to ensure sustainable use. It is also a valuable source of food and medicine for local communities, with various parts of the tree being used for traditional remedies and as a food source for wildlife.",
      bullet_desc: [
        "Belongs to the Bignoniaceae family of flowering trees", 
        "Native to Central and South America", 
        "Can grow up to 45 meters in height and have a trunk diameter of up to 2 meters", 
        "Has gray, smooth bark with shallow fissures", 
        "Produces deciduous and pinnate leaves with 5-7 glossy elliptical leaflets",
        "Flowers are tubular and trumpet-shaped, and range in color from yellow to pink and purple",
        "Produces a woody capsule fruit containing numerous small seeds",
        "Wood is extremely dense, hard, and resistant to decay, insects, and weathering",
        "Ideal for outdoor applications such as decking, siding, and fencing",
        'Dark brown to olive-green in color with a fine, straight grain pattern that can be interlocked or irregular', 
        "Used for centuries in the construction of docks, bridges, and other marine structures due to its durability and resistance to rot",
        "Valuable source of food and medicine for local communities, and provides food for wildlife.",
        "Harvested from managed forests to ensure sustainable use"
      ],
      image: 'ipe.png',
      category_id: 7
    )

    #mahogany 15
    Product.create!(
      name: 'Mahogany (Swietenia spp.)' ,
      amount: 30000,
      price: 999.99,
      description: "Swietenia spp., commonly known as Mahogany, is a group of tropical hardwood tree species native to Central and South America. It belongs to the Meliaceae family and is known for its reddish-brown wood that is prized for furniture, cabinetry, and musical instruments.

      Mahogany trees can grow up to 30 meters in height and have a trunk diameter of up to 1.5 meters. The bark is gray-brown and relatively smooth, with shallow fissures. The leaves are deciduous and pinnate, with 4-8 pairs of leaflets that are lanceolate in shape and have a shiny surface. The flowers are small, inconspicuous, and range in color from white to pale pink or yellow. The fruit is a large, woody capsule that contains numerous small seeds.
      
      The wood of Mahogany is medium to hard in density and has a fine, straight grain pattern that is sometimes interlocked or irregular. It has a reddish-brown color and a high luster when polished. Due to its durability, workability, and attractive appearance, Mahogany wood has been used for centuries in high-quality furniture and cabinetry, as well as in the construction of boats, musical instruments, and decorative objects.
      
      Mahogany trees are slow-growing and are often harvested from managed forests to ensure sustainable use. They are also a valuable source of food and shelter for local wildlife, and have cultural and medicinal significance for many indigenous communities. However, the demand for Mahogany wood has led to overexploitation and illegal logging in some regions, leading to conservation concerns and efforts to promote responsible harvesting and trade practices.",
      bullet_desc: [
        "Tropical hardwood tree species native to Central and South America", 
        "Belongs to the Meliaceae family", 
        "Can grow up to 30 meters in height and have a trunk diameter of up to 1.5 meters", 
        "Bark is gray-brown and relatively smooth, with shallow fissures", 
        "Leaves are deciduous and pinnate, with 4-8 pairs of lanceolate-shaped leaflets that have a shiny surface",
        "Flowers are small and range in color from white to pale pink or yellow",
        "Fruit is a large, woody capsule that contains numerous small seeds",
        "Wood is medium to hard in density and has a fine, straight grain pattern that is sometimes interlocked or irregular",
        "Has a reddish-brown color and a high luster when polished",
        "Durable, workable, and attractive, it is commonly used for high-quality furniture, cabinetry, boats, musical instruments, and decorative objects", 
        "Slow-growing and often harvested from managed forests to ensure sustainable use",
        "Valuable source of food and shelter for local wildlife, and has cultural and medicinal significance for many indigenous communities",
        "Overexploitation and illegal logging have led to conservation concerns and efforts to promote responsible harvesting and trade practices."
      ],
      image: 'mahogany.png',
      category_id: 7
    )

    #brazil nut (Bertholletia excelsa) 16
    Product.create!(
      name: 'Brazil Nut (Bertholletia excelsa)' ,
      amount: 30000,
      price: 999.99,
      description: "The Brazil Nut (Bertholletia excelsa) is a large tree species that can grow up to 50 meters in height and have a trunk diameter of up to 2 meters. Belonging to the Lecythidaceae family and native to the Amazon rainforest, the Brazil Nut has a straight, cylindrical trunk with smooth, gray-brown bark. Its leaves are alternate and pinnate, with 8-24 pairs of oval-shaped leaflets. The flowers are large and white or pale pink, and are pollinated by bees that collect nectar from them. The fruits are large, spherical capsules that contain 12-24 triangular seeds, each enclosed in a hard, woody shell. The seeds, known as Brazil nuts, are a rich source of protein, healthy fats, and minerals such as selenium, and are consumed by people and wildlife alike.

      The trees have an important role in the ecology of the Amazon rainforest, providing habitat and food for a variety of species, and contributing to the forest's nutrient cycling and carbon storage. They are also of cultural and economic importance to local communities, who harvest the nuts and sell them as a cash crop. Sustainable management practices, such as selective harvesting and protection of mature trees, are crucial to ensure the long-term viability of the Brazil nut industry and the conservation of the forests where they grow. Overall, the Brazil Nut is a valuable species that highlights the importance of maintaining healthy and sustainable ecosystems.",
      bullet_desc: [
        "A large tree species that can grow up to 50 meters in height and have a trunk diameter of up to 2 meters", 
        "Belongs to the Lecythidaceae family and is native to the Amazon rainforest", 
        "Has a straight, cylindrical trunk with smooth, gray-brown bark", 
        "Leaves are alternate and pinnate, with 8-24 pairs of oval-shaped leaflets", 
        "Flowers are large and white or pale pink, and are pollinated by bees that collect nectar from them",
        "Fruits are large, spherical capsules that contain 12-24 triangular seeds, each enclosed in a hard, woody shell",
        "The seeds, known as Brazil nuts, are a rich source of protein, healthy fats, and minerals such as selenium, and are consumed by people and wildlife alike",
        "The trees have an important role in the ecology of the Amazon rainforest, providing habitat and food for a variety of species, and contributing to the forest's nutrient cycling and carbon storage",
        "They are also of cultural and economic importance to local communities, who harvest the nuts and sell them as a cash crop",
        "Sustainable management practices, such as selective harvesting and protection of mature trees, are crucial to ensure the long-term viability of the Brazil nut industry and the conservation of the forests where they grow.", 
      ],
      image: 'brazilnut.png',
      category_id: 7
    )

    #jatoba 17
    Product.create!(
      name: 'Jatoba (Hymenaea courbaril)' ,
      amount: 30000,
      price: 999.99,
      description: "Jatoba, also known as Brazilian Cherry or Courbaril, is a large tree species belonging to the Fabaceae family, and is native to the tropical regions of South and Central America. The tree can reach up to 50 meters in height, with a trunk diameter of up to 2 meters. It has a straight, cylindrical trunk with dark brown to gray bark, and its leaves are alternate and compound, with 5-8 pairs of glossy, oval-shaped leaflets. Jatoba is a deciduous tree, and its leaves turn yellow before shedding in the dry season.

      The flowers of Jatoba are small, yellow or greenish-yellow, and are borne in dense clusters on the branches. The tree is pollinated by bees and other insects, and the fruits are large, woody pods that contain several seeds. The seeds are enclosed in a red, fibrous aril that is edible and sweet, and is a popular snack in many parts of South America.
      
      Jatoba is known for its hard, dense wood, which is resistant to decay, insect attack, and fire. The wood is a rich reddish-brown color, and has a fine, uniform texture with a straight or slightly interlocked grain. It is widely used in furniture-making, flooring, and construction, and is prized for its durability and beauty. Jatoba is also used in traditional medicine to treat a variety of ailments, and is believed to have anti-inflammatory and analgesic properties.
      
      Jatoba is an important species in the ecology of tropical forests, providing habitat and food for a variety of species, and contributing to the nutrient cycling and carbon storage of the ecosystem. However, like many tropical hardwoods, Jatoba is threatened by overharvesting and habitat destruction. Sustainable management practices, such as selective harvesting and reforestation, are crucial to ensure the long-term viability of the species and the forests where they grow.",
      bullet_desc: [
        "Jatoba is a large deciduous tree species native to tropical regions of South and Central America.", 
        "The tree can reach up to 50 meters in height with a straight, cylindrical trunk and dark brown to gray bark.", 
        "Jatoba leaves are alternate and compound with 5-8 pairs of glossy, oval-shaped leaflets that turn yellow before shedding in the dry season.", 
        "The tree is pollinated by bees and other insects, and its large, woody fruit pods contain edible and sweet, red, fibrous arils that are popular snacks in South America.", 
        "Jatoba wood is hard, dense, and resistant to decay, insect attack, and fire, and has a rich reddish-brown color with a fine, uniform texture and straight or slightly interlocked grain.",
        "Jatoba wood is widely used in furniture-making, flooring, and construction for its durability and beauty.",
        "Jatoba is also used in traditional medicine for its believed anti-inflammatory and analgesic properties.",
        "Jatoba plays an important ecological role in tropical forests by providing habitat and food for a variety of species, and contributing to the nutrient cycling and carbon storage of the ecosystem.",
        "Sustainable management practices, such as selective harvesting and reforestation, are crucial to ensure the long-term viability of Jatoba and its associated ecosystems.",
      ],
      image: 'jatoba.png',
      category_id: 7
    )

    #Kapok (Ceiba pentandra) 18
    Product.create!(
      name: 'Kapok (Ceiba pentandra)' ,
      amount: 30000,
      price: 999.99,
      description: "Ceiba pentandra, commonly known as kapok, is a large deciduous tree species that is native to the tropical regions of Africa, Asia, and South America. It can reach up to 70 meters in height and its trunk can be over 3 meters in diameter. The bark is smooth and gray, with large buttresses at the base of the tree for added support. Kapok leaves are large and palmately compound, with 5 to 9 leaflets that are elliptic and glossy green. The tree produces large, bell-shaped flowers that are creamy white with purple spots, and these are followed by brown, woody fruits that contain cotton-like fibers. The fibers, known as kapok, are buoyant and water-resistant, and are traditionally used for stuffing pillows, mattresses, and life jackets. Kapok wood is soft and light, and is not typically used for commercial purposes. Kapok plays an important ecological role in tropical forests by providing habitat and food for a variety of species, and contributing to the nutrient cycling and carbon storage of the ecosystem. Sustainable management practices, such as reforestation and habitat restoration, are crucial to ensure the long-term viability of kapok and its associated ecosystems.",
      bullet_desc: [
        "Large deciduous tree species native to tropical regions of Africa, Asia, and South America", 
        "Can reach up to 70 meters in height with a trunk diameter of over 3 meters", 
        "Smooth gray bark with large buttresses at the base for added support", 
        "Large palmately compound leaves with 5-9 elliptic and glossy green leaflets", 
        "Produces large, bell-shaped flowers that are creamy white with purple spots",
        "Brown, woody fruits contain buoyant, water-resistant kapok fibers traditionally used for stuffing pillows, mattresses, and life jackets",
        "Kapok wood is soft and light, and not typically used for commercial purposes",
        "Plays an important ecological role in tropical forests by providing habitat and food for a variety of species, and contributing to nutrient cycling and carbon storage",
        "Sustainable management practices are crucial for long-term viability of kapok and associated ecosystems",
      ],
      image: 'Kapok.png',
      category_id: 7
    )

    #all terrain vehicle 19
    Product.create!(
      name: 'Blue Thunder ATV' ,
      amount: 90000,
      price: 500.99,
      description: "The Blue Thunder ATV stands out with its captivating blue exterior, exuding a sense of confidence and adventure. Its sleek design is complemented by robust construction, ensuring durability and reliability in the face of rugged landscapes and challenging trails. This ATV is built to handle anything you throw at it!

      Equipped with a potent engine, the Blue Thunder delivers an adrenaline-pumping performance that will leave you craving for more. With its exceptional horsepower and torque, this beast effortlessly tackles steep inclines, muddy terrains, and rocky paths, making it the perfect companion for thrill-seekers and outdoor enthusiasts.
      
      The ATV's suspension system has been meticulously engineered to provide an exceptionally smooth ride, absorbing shocks and bumps with ease. Whether you're cruising along forest trails, exploring sandy dunes, or conquering rocky mountainsides, the Blue Thunder's suspension ensures maximum comfort and control.
      
      Safety is always a top priority, and the Blue Thunder ATV doesn't disappoint. It features advanced safety features, including responsive brakes, sturdy roll bars, and integrated lighting, allowing you to navigate confidently even in low-light conditions. The ATV also comes equipped with ergonomic handlebars and a comfortable seating arrangement, ensuring a comfortable and enjoyable riding experience.
      
      With ample storage space, the Blue Thunder ATV allows you to bring all your essentials for an epic adventure. Load up your camping gear, fishing equipment, or picnic supplies, and head out on a thrilling expedition without any worries about storage limitations.
      
      Whether you're an experienced rider or a novice looking to explore the great outdoors, the Blue Thunder ATV offers an incredible blend of power, performance, and style. It's time to unleash your inner adventurer and embrace the freedom of the open trails with the Blue Thunder ATV! Don't miss out on the opportunity to own this exhilarating machine that will make every ride an unforgettable experience. Get ready to dominate the off-road world in style!",
      bullet_desc: [
        "Stunning blue exterior that stands out from the crowd", 
        "Powerful and reliable all-terrain vehicle", 
        "Designed for off-roading adventures and conquering challenging terrains", 
        "Durable construction with a robust frame for maximum durability", 
        "High ground clearance for navigating obstacles with ease",
        "Smooth and responsive handling for a thrilling riding experience",
        "Equipped with a powerful engine for impressive acceleration and top speed",
        "Comfortable seating and ergonomic design for long rides",
        "Ample storage space for all your gear and equipment",
        "Easy to maintain and service for hassle-free ownership",
        "Safety features such as headlights, taillights, and a sturdy roll cage",
        "Perfect for outdoor enthusiasts, adventurers, and thrill-seekers alike"
      ],
      image: 'atv.png',
      category_id: 8
    )

    #all terrain vehicle 20
    Product.create!(
      name: 'X-PRO Adult ATV Quad Four Wheelers 200 Utility ATV Full Size ATV Quad Adult ATVs,Black' ,
      amount: 90000,
      price: 2449.99,
      description: "Designed to conquer even the harshest terrains, the Black ATV combines durability and performance seamlessly. Its robust construction ensures it can withstand the toughest challenges, while the high ground clearance allows you to effortlessly navigate over rocks, mud, and uneven surfaces. Whether you're tackling mountains, forests, or desert dunes, this ATV will take you there.

      Underneath the hood, the Black ATV boasts a powerful engine that delivers impressive acceleration and top speed, giving you the adrenaline rush you crave. Its responsive handling and precise controls provide an exhilarating riding experience, making every journey an unforgettable one.
      
      Comfort is a top priority with the Black ATV. The ergonomically designed seating ensures maximum comfort, even during long rides, allowing you to focus on the adventure ahead. Plus, the ATV provides ample storage space for all your gear and essentials, so you can bring everything you need for an epic excursion.
      
      Safety is paramount, and the Black ATV is equipped with essential features to keep you protected. From reliable headlights that illuminate the darkest trails to a sturdy roll cage that provides added security, this ATV prioritizes your well-being while you conquer the outdoors.
      
      Maintenance is a breeze with the Black ATV, thanks to its user-friendly design and easy-to-access components. This means less time spent on repairs and more time enjoying the thrill of the ride.",
      bullet_desc: [
        "200cc Utility ATV broght by XPROUSA.", 
        "Manual Transmission lets you be in full control of your 4-wheeler. The Reverse feature allows you to move your ATV backwards with ease without you having to get out of the ATV.", 
        'Full size at 69.3" length, 42.1" Width, 43.3 " Height provide a roomy and comfortable riding, that give more space for growing out.', 
        "Luggage Rack is on the front and rear of the ATV. This is a fantastic upgrade for carrying anything needed.", 
        "High ground clearance for navigating obstacles with ease",
        "Smooth and responsive handling for a thrilling riding experience",
        "Equipped with a powerful engine for impressive acceleration and top speed",
        "Comfortable seating and ergonomic design for long rides",
        "Some assembly required: Assembly for ATVs include Handle bar brackets, all 4 wheels, front and rear racks, rear shock and battery.",
        "Easy to maintain and service for hassle-free ownership",
        "Safety features such as headlights, taillights, and a sturdy roll cage",
        "Perfect for outdoor enthusiasts, adventurers, and thrill-seekers alike"
      ],
      image: 'atv2.png',
      category_id: 8
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
      body: "The leaf is even more impressive in person, with its vibrant green color and intricate veins creating a texture that is simply breathtaking. The size of the leaf is truly impressive and adds a touch of natural beauty to my home that I didn't even realize was missing until I added it.

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
      body: "I bought the large leaf and while it is certainly a beautiful piece, I can't help feeling a bit sad about my purchase. Unfortunately, the leaf arrived with a few small tears along the edges, which took away from its natural beauty. I was looking forward to displaying it in a prominent spot in my home, but now I'm not sure if I want to showcase it at all.

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

  #Cast iron reviews (product_id: 7)
    Review.create!(
      body: "I absolutely love my cast iron! It's incredibly durable and versatile, and it makes cooking a joy. Highly recommend!",
      product_id: 7,
      score: 5,
      user_id: 6
    )

    Review.create!(
      body: "I'm really disappointed with my cast iron. It's so heavy and hard to handle. Would not recommend.",
      product_id: 7,
      score: 1,
      user_id: 8
    )

  #Capybara reviews (product_id: 3)

    Review.create!(
      body: "They are so cute!",
      product_id: 3,
      score: 5,
      user_id: 3
    )

    Review.create!(
      body: "I was scared for my life when one of them approached me.",
      product_id: 3,
      score: 1,
      user_id: 4
    )

  #jaguar  reviews (product_id: 4)

    Review.create!(
      body: "HUGE CAT!",
      product_id: 4,
      score: 5,
      user_id: 9
    )

    Review.create!(
      body: "Reminds me of my cat Whiskers",
      product_id: 4,
      score: 4,
      user_id: 2
    )

  #squirrel monkey (product_id: 11)
  
    Review.create!(
      body: "They are so tiny and cute!!!",
      product_id: 11,
      score: 5,
      user_id: 5
    )

    Review.create!(
      body: "I would raise one if I could. They are so lovely and cute!",
      product_id: 11,
      score: 5,
      user_id: 1
    )

  #charcoal reviews (product_id: 9)
    Review.create!(
      body: "Lovely charcoal fuel! Has never let me down. Always kept the fire going after only one ignition. Saves me a lot of hassle by working immediately! Highly recommend!",
      product_id: 9,
      score: 5,
      user_id: 8
    )
  #atv reviews (product_id: 19)
    Review.create!(
      body: "Such a nice vehicle! I bought my baby 2 years ago and had no problems with it. Take care of her every day. Highly recommend!",
      product_id: 19,
      score: 5,
      user_id: 6
    )
  
  #atv2 reviews (product_id: 20)
    Review.create!(
      body: "Great ATV! I would take this one over the blue one. Highly recommend!",
      product_id: 20,
      score: 5,
      user_id: 9
    )

  #kapok reviews (product_id: 18)
    Review.create!(
      body: "I felt inferior to its humongous height.",
      product_id: 18,
      score: 4,
      user_id: 8
    )

    Review.create!(
      body: "If I were this tall I would be the #1 NBA player",
      product_id: 18,
      score: 5,
      user_id: 5
    )
  # janira beanie reviews (product_id: 5)
    Review.create!(
      body: "Super comfortable and smooth beanie! I love the texture.",
      product_id: 5,
      score: 5,
      user_id: 1
    )
  #charcoal (product_id: 8)
    Review.create!(
      body: "Made the fire last for so long! Gave a unique flavor to my hotdogs. Really good!",
      product_id: 8,
      score: 5,
      user_id: 7
    )

  # giant fish (product_id: 12)
    Review.create!(
      body: "Very large fish, but I've seen bigger.",
      product_id: 12,
      score: 4,
      user_id: 4
    )
  
  puts "Done!"
end
