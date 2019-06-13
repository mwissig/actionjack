

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
