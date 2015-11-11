require 'dotenv'
Dotenv.load
require './config_twitter'

TweetStream::Client.new.track('#psg', '#edf') do |status|
  puts "#{status.text}"
end
