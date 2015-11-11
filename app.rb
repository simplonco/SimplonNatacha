# encoding: utf-8

require 'dotenv'
require 'pry'
Dotenv.load
require './pump'
require './temperature'
require './moisture'
require './config_twitter'

TweetStream::Client.new.track('#see', 'SimplonNatacha') do |status|
  tweet = status.text.downcase
  account = "@#{status.user.screen_name}"
  puts tweet

  if tweet.match /(?=.*simplonnatacha)(?=.*see)((?=.*arrosage)|(?=.*water)).*/
    Pump.open(2)
    @client.update("Merci #{account}, je commencais à avoir soif :)")
  end

  if tweet.match /(?=.*simplonnatacha)(?=.*see)((?=.*ca va)|(?=.*ça va)|(?=.*info)).*/
    @client.update("Je m'appelle Natacha et je suis une plante connectée. Huidité: #{Moisture.get}%, Tempéture: #{Temperature.get}° #simplon #{account}")
  end
end
