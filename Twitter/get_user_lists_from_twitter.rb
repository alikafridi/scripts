=begin
Author: Ali Afridi
Last Updated: 11/20/2015

This script will get all the twitter lists a user has created. 
=end

require 'yaml'
require 'twitter'
require 'csv'

# toggle the flags below to match your preferences
save_to_csv = true
output_to_terminal = true
output_file = "results.csv"

# Gets the authentication information from a file called secrets.yml
secrets = YAML.load_file ('../secrets.yml')
twitter ||= Twitter::REST::Client.new do |config|
  config.consumer_key        = secrets["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = secrets["TWITTER_CONSUMER_SECRET"]
  config.access_token        = secrets["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = secrets["TWITTER_TOKEN_SECRET"]
end

userlists = twitter.lists

if output_to_terminal
	userlists.each do |list|
		puts list.name
	end
end

if save_to_csv
	CSV.open( output_file, 'w' ) do |writer|
		userlists.each do |list|
			writer << [list.name]
		end
	end
end