=begin  
Author: Ali K. Afridi
Last Updated: 4/17/2016

Creates a csv with a list of all products that have "bot" or "chat" in the
products name or tagline.

=end

require 'HTTParty'
require 'open-uri'
require 'json'
require 'openssl'
require 'csv'

secrets = YAML.load_file ('../../secrets.yml') # This file contains the twitter access information
key = secrets["PRODUCT_HUNT_ACCESS_TOKEN"]

start_days_ago = 0
max_days_ago = 365

CSV.open( "results.csv", 'w' ) do |writer|
  for i in start_days_ago..max_days_ago
      puts "Days: #{i}"
      response = HTTParty.get("https://api.producthunt.com/v1/posts/?access_token=#{key}&days_ago=#{i}")
      poster = response["posts"]

      poster.each do |post|

      	if post["tagline"].include?("chat") || post["tagline"].include?("bot") || post["name"].include?("chat") || post["name"].include?("bot")
        	writer << [i, post["day"], post["name"], post["tagline"], post["created_at"]]
      	end
      end # /poster.each
  end # for i in start_days_ago..max_days_ago
end # CSV.open