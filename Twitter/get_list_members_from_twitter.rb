=begin
Author: Ali Afridi
Last Updated: 11/20/2015

This script will get the members in a twitter list. 
The twitter keys and access tokens should be for the owner of the list.
=end

require 'yaml'
require 'twitter'

# Slug/handle for the list you want to get members of
slug = "hackers" 

# Gets the authentication information from a file called secrets.yml
secrets = YAML.load_file ('../secrets.yml')
twitter ||= Twitter::REST::Client.new do |config|
  config.consumer_key        = secrets["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = secrets["TWITTER_CONSUMER_SECRET"]
  config.access_token        = secrets["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = secrets["TWITTER_TOKEN_SECRET"]
end

userlists = twitter.lists
list_id = nil

userlists.each do |list|
	if (list.slug == slug)
		list_id = list.id
	end
end

if (list_id != nil)
	members = twitter.list_members(list_id)
	members.each do |member|
		puts member.screen_name
	end
end