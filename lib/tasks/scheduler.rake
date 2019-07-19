

desc "Deletes old chats"
task :delete_old_data => :environment do
  puts "Deleting old data"
  Lobbychat.where('created_at < ?', 14.days.ago).each do |post|
    post.destroy
  end
  Tictactoe.where('updated_at < ?', 14.days.ago).each do |game|
    game.destroy
  end
  puts "done."
end

desc "Gives all users 100 points and make pets hungry"
task :give_points => :environment do
  puts "Giving everyone 100 points"
  User.all.each do |user|
    user.increment!(:points, 100)
  end

  @pets = Item.where(category: "pets")
  @hatched_eggs = @pets.where.not(name: "Egg")
  @hatched_eggs.where('datetime1 < ?', 6.hours.ago).or(@hatched_eggs.where(datetime1: nil)).each do |pet|
    if pet.integer1 > 0
      pet.decrement!(:integer1, 1)
    end
  end

  puts "activating auto feeders"
@autofeeders = Item.where(name: "Automatic Pet Feeder")
@autofeeders.each do |feeder|
@pets = feeder.user.items.where(category: "pets").where.not(name: "Egg")
@hungrypets = []
  @pets.each do |pet|
    if pet.integer1 < pet.integer2
      @hungrypets << pet
    end
  end

  if feeder.integer1 >= @hungrypets.count
    @hungrypets.each do |pet|
      pet.increment!(:integer1, 1)
      feeder.decrement!(:integer1, 1)
    end
  end
end
    puts "done."

  puts "spawning poop"
    @poops = ["small", "small", "small", "medium"]
@fed_animals = @hatched_eggs.where('datetime1 > ?', 24.hours.ago)
@fed_animals.each do |animal|
      @pooptype = @poops.sample
      if @pooptype == "small"
      Item.create(
        user_id: animal.user_id,
        name: "Small Poop",
        category: "waste",
        image: "small_poop.png",
        shop_price: 0,
        sellback_price: 0,
        description: "Poop.",
        long_description: "Poop.",
      )
    elsif @pooptype == "medium"
      Item.create(
        user_id: animal.user_id,
        name: "Medium Poop",
        category: "waste",
        image: "medium_poop.png",
        shop_price: 0,
        sellback_price: 0,
        description: "Poop.",
        long_description: "Poop.",
      )
    end
  end
  puts "done."



end

desc "Activates user accounts"
task :activate_accounts => :environment do
  puts "Activating inactive accounts"
  User.all.where(email_confirmed: false).each do |user|
    user.email_confirmed = true
    user.save(validate: false)
  end
  puts "done."
end

desc "Creates the slot machine db"
task :build_slot => :environment do
  puts "Making slot machine"
  Slot.create(
    jackpot: 1000,
    biggest_prize: 0
  )
  puts "done."
end

desc "Build mine"
task :build_mine => :environment do
  puts "Creating mine tiles"
  @x_axis = (1..40).to_a
  @y_axis = (1..300).to_a
  @coords = []
  @x_axis.each do |x|
    @y_axis.each do |y|
      Minetile.create(
      xcoord: x,
      ycoord: y,
      coords: x.to_s + '_' + y.to_s
    )
    end
  end
  puts "done."
end

desc "Shape mine"
task :shape_mine => :environment do
  puts "Changing mine tiles"
  Minetile.all.each do |tile|
    if tile.xcoord <= 15
      tile.bgclass = "sky-background"
      tile.fgclass = "empty"

      if tile.xcoord <= 12
          @nums = (1..20).to_a
          @rand = @nums.sample
            if @rand == 1
              tile.bgclass = "sky-background bgcloud"
              tile.fgclass = "empty"
            end
        end

         if tile.xcoord == 15
          @nums = (1..17).to_a
          @rand = @nums.sample
            if @rand == 3
              tile.fgclass = "rock"
            elsif @rand == 4 || @rand == 5
              tile.fgclass = "wood"
            else
              tile.fgclass = "empty"
            end
        end

    else

      tile.bgclass = "cave-background"
      @nums = (1..17).to_a
      @rand = @nums.sample
        if @rand == 3
          tile.fgclass = "rock"
            else
              if tile.xcoord <= 30
                tile.fgclass = "soil"
              else
                tile.fgclass = "soil2"
              end
            end

            if tile.xcoord > 25
              @nums = (1..35).to_a
              @rand = @nums.sample
              if @rand == 1
                tile.fgclass = "ironore"
              end
            end

            if tile.xcoord > 30
              @nums = (1..50).to_a
              @rand = @nums.sample
              if @rand == 1
                tile.fgclass = "silverore"
              end
            end

            if tile.xcoord > 35
              @nums = (1..60).to_a
              @rand = @nums.sample
              if @rand == 1
                tile.fgclass = "goldore"
              end
            end

            if tile.xcoord >= 38
              @nums = (1..200).to_a
              @rand = @nums.sample
              if @rand == 1
                tile.fgclass = "diamond"
              end
            end

            if tile.xcoord == 16
              @nums = (1..2).to_a
              @rand = @nums.sample
              if @rand == 1
                tile.bgclass = "bggrass"
              else
                tile.bgclass = "cave-background"
              end
            end

            if tile.xcoord == 40
              tile.fgclass = "unbreakable"
            end

          end
          tile.save!
        end
  puts "mine generated"
end

desc "Hatches the egg"
task :hatch_eggs => :environment do
  puts "Hatching egg"
  @pets = ["treehopper", "jerboa", "axolotl"]
@eggs = Item.where(name: "Egg")
@ready_eggs = @eggs.where('created_at < ?', 3.days.ago)
@egg_outcomes = []
@ready_eggs.each do |egg|
  @pet = @pets.sample
  if @pet == "treehopper"
    Item.create(
      user_id: egg.user_id,
      name: "Treehopper",
      category: "pets",
      image: "treehopper.png",
      shop_price: 0,
      sellback_price: 3000,
      description: "A treehopper.",
      long_description: "A treehopper. Integer1 value of pet is current hunger and integer2 is max hunger. Datetime1 is time last fed.",
      integer1: 0,
      integer2: 1
    )
  elsif @pet == "jerboa"
    Item.create(
      user_id: egg.user_id,
      name: "Jerboa",
      category: "pets",
      image: "jerboa.png",
      shop_price: 0,
      sellback_price: 3500,
      description: "A jerboa.",
      long_description: "A jerboa. Integer1 value of pet is current hunger and integer2 is max hunger. Datetime1 is time last fed.",
      integer1: 0,
      integer2: 2
    )
  elsif @pet == "axolotl"
    Item.create(
      user_id: egg.user_id,
      name: "Axolotl",
      category: "pets",
      image: "axolotl.png",
      shop_price: 0,
      sellback_price: 4000,
      description: "An axolotl.",
      long_description: "An axolotl. Integer1 value of pet is current hunger and integer2 is max hunger. Datetime1 is time last fed.",
      integer1: 0,
      integer2: 3
    )
  end
  egg.destroy!
  @notification = Notification.create(
    user_id: egg.user_id,
    body: 'An egg has hatched in your inventory.',
    game: 'egg',
  )
  @to_user = User.find_by(id: @notification.user_id)
  @notecount = @to_user.notifications.where(read: false).count
  ActionCable.server.broadcast 'notifications_channel',
                  notecount: @notecount
end
  puts "done."
end

desc "adds items to shop"
task :add_shop_items => :environment do
  puts "Populating shop"
  Shopitem.create(
    name: "Iron Pickaxe",
    category: "pickaxes",
    material: "steel",
    image: "pickaxe_iron.png",
    shop_price: 500,
    sellback_price: 250,
    description: "An iron pickaxe.",
    long_description: "An iron pickaxe. Can mine rock. Integer1 value of pickaxe is level.",
    integer1: 1
  )
  puts "done."
end

desc "storage for item data"
task :create_item => :environment do
  puts "Populating shop"
  Shopitem.create(
    name: "Wooden Sword",
    category: "weapons",
    material: "wood",
    quality: "starter",
    image: "sword_wood.png",
    shop_price: 500,
    sellback_price: 250,
    description: "A wooden sword.",
    long_description: "A basic wooden sword. Integer1 value of weapons is attack power.",
    integer1: 10
  )
  Shopitem.create(
    name: "Iron Pickaxe",
    category: "pickaxes",
    material: "steel",
    image: "pickaxe_iron.png",
    shop_price: 500,
    sellback_price: 250,
    description: "An iron pickaxe.",
    long_description: "An iron pickaxe. Can mine rock. Integer1 value of pickaxe is level.",
    integer1: 1
  )
  Shopitem.create(
    name: "Steel Pickaxe",
    category: "pickaxes",
    material: "steel",
    image: "pickaxe_steel.png",
    shop_price: 2000,
    sellback_price: 1000,
    description: "A steel pickaxe.",
    long_description: "A steel pickaxe. Can mine iron ore. Integer1 value of pickaxe is level.",
    integer1: 2
  )
  Shopitem.create(
    name: "Titanium Pickaxe",
    category: "pickaxes",
    material: "titanium",
    image: "pickaxe_titanium.png",
    shop_price: 1000,
    sellback_price: 500,
    description: "A titanium pickaxe.",
    long_description: "A titanium pickaxe. Can mine silver ore. Integer1 value of pickaxe is level.",
    integer1: 3
  )
  Shopitem.create(
    name: "Plum",
    category: "food",
    image: "plum.png",
    shop_price: 10,
    sellback_price: 5,
    description: "A plum.",
    long_description: "A plum. Integer1 value of food is the amount it reduces hunger.",
    integer1: 5
  )
  Shopitem.create(
    name: "Cassava Bread",
    category: "food",
    image: "cassava_bread.png",
    shop_price: 200,
    sellback_price: 100,
    description: "Bread made from cassava flour.",
    long_description: "Cassava bread. Integer1 value of food is the amount it reduces hunger.",
    integer1: 100
  )
  Shopitem.create(
    name: "Wood",
    category: "mine",
    image: "wood.png",
    shop_price: "do not sell in shop?",
    sellback_price: "calculate based on integer1",
    description: "Wood",
    long_description: "Wood. Integer1 for mined items is amount. Write code to generate sellback price based on this number.",
    integer1: "generate based on number of item in inventory"
  )
  Shopitem.create(
    name: "Automatic Pet Feeder",
    category: "automator",
    image: "pet_feeder.png",
    shop_price: 10000,
    sellback_price: 5000,
    description: "Load food into this automatic pet feeder and it will feed all of your pets daily.",
    long_description: "Load food into this automatic pet feeder and it will feed all of your pets daily. Integer1 is the amount of food in the feeder.",
    integer1: 0,
    string1: "pet_feeder_not_ready.png",
    string2: "pet_feeder_loaded.png",
  )
  puts "done."
end
