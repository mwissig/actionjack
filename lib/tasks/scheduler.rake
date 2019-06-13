

desc "Deletes old chats"
task :delete_old_posts => :environment do
  puts "Deleting old posts"
  Lobbychat.where('created_at < ?', 14.days.ago).each do |post|
    post.destroy
  end
  puts "done."
end

desc "This task is called by the Heroku scheduler add-on"
task :give_points => :environment do
  puts "Giving everyone 100 points"
  User.all.each do |user|
    user.increment!(:points, 100)
  end
  puts "done."
end
