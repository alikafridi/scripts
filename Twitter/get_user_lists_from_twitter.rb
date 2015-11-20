=begin
Author: Ali Afridi
Last Updated: 11/20/2015

This script will get all the twitter lists a user has created. 
=end

require 'yaml'
require 'twitter'

secrets = YAML.load_file ('../secrets.yml')

twitter ||= Twitter::REST::Client.new do |config|
  config.consumer_key        = secrets["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = secrets["TWITTER_CONSUMER_SECRET"]
  config.access_token        = secrets["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = secrets["TWITTER_TOKEN_SECRET"]
end

userlists = twitter.lists

userlists.each do |list|
	puts list.name
end
