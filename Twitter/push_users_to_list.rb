=begin
Author: Ali Afridi
Last Updated: 12/26/2015

This script will add all people from a text file to a twitter list.
=end

require 'yaml'
require 'twitter'
require 'csv'

# Configure these params
file_name = "in2.csv"
list_slug = "follow-old"
owner_handle = "@AliKAfridi"

# Twitter Auth
secrets = YAML.load_file ('../secrets.yml')
twitter ||= Twitter::REST::Client.new do |config|
  config.consumer_key        = secrets["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = secrets["TWITTER_CONSUMER_SECRET"]
  config.access_token        = secrets["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = secrets["TWITTER_TOKEN_SECRET"]
end

# Input handles from file name and push to twitter
CSV.foreach(file_name) do |row|
	handle = row[0].gsub(/\s+/, "")
	twitter.add_list_member(owner_screen_name: owner_handle, slug: list_slug, screen_name: handle)
end