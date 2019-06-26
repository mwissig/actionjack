

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

desc "Gives all users 100 points"
task :give_points => :environment do
  puts "Giving everyone 100 points"
  User.all.each do |user|
    user.increment!(:points, 100)
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

desc "Hatches the egg"
task :hatch_eggs => :environment do
  puts "Hatching egg"
@eggs = Item.where(name: "egg")
@ready_eggs = @eggs.where('created_at < ?', 14.days.ago)
@egg_outcomes = []
@ready_eggs.each do |egg|
  Item.create(
    name: "pet"
  )
  egg.destroy!
end
  puts "done."
end

desc "spawn poop"
task :poop => :environment do
  puts "pooping"
@pets = Item.where(category: "pets")
@hatched_eggs = @pets.where.not(name: "Egg")
@fed_animals = @animals.where('integer1 >= ?', 0)
@egg_outcomes = []
@ready_eggs.each do |egg|
  Item.create(
    name: "Small Poop"
  )
  egg.destroy!
end
  puts "done."
end

desc "adds items to shop"
task :add_shop_items => :environment do
  puts "Populating shop"
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
    name: "Plum",
    category: "food",
    image: "plum.png",
    shop_price: 10,
    sellback_price: 5,
    description: "A plum.",
    long_description: "A plum. Integer1 value of food is the amount it reduces hunger.",
    integer1: 5
  )
  puts "done."
end
