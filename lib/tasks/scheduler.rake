desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  TweetCrawler.new('nasa')
  TweetCrawler.new('healthcare')
  TweetCrawler.new('ruby')
  puts "done."
end