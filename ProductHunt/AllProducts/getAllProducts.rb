=begin  
Author: Ali K. Afridi
Started: 5/03/2016

Creates a csv with a list of all products along with their info.

=end

require 'HTTParty'
require 'open-uri'
require 'json'
require 'openssl'
require 'csv'

secrets = YAML.load_file ('../../secrets.yml') # This file contains the twitter access information
key = secrets["PRODUCT_HUNT_ACCESS_TOKEN"]

start_days_ago = 1
max_days_ago = 1000

CSV.open( "results.csv", 'w' ) do |writer|
	i = start_days_ago
	while i < max_days_ago do

		begin 
      puts "Days: #{i}"
      response = HTTParty.get("https://api.producthunt.com/v1/posts/?access_token=#{key}&days_ago=#{i}")
      poster = response["posts"]

      poster.each do |post|
      	writer << [i, post["category_id"], post["day"], post["id"],  post["name"], post["product_state"], post["tagline"], post["comments_count"], post["created_at"], post["discussion_url"], post["exclusive"], post["featured"], post["maker_inside"], post["makers"], post["platforms"], post["topics"], post["redirect_url"], post["featured"], post["user"]["id"], post["user"]["twitter_username"], post["votes_count"]]
      end # /poster.each
   		i = i + 1
    rescue
    end

  end # while i in start_days_ago..max_days_ago
end # CSV.open
