=begin
Author: Ali Afridi
Last Updated: 12/26/2015

This script will add all people from a text file to a twitter list.
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

