=begin  
Author: Ali K. Afridi
Last Updated: 12/21/2015

This script goes through Product Hunt to get a list of all the makers for featured Products.
It then attempts to find the makers on Twitter, and gets their location if they have one listed on their Twitter profile. 

=end

require 'HTTParty'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'openssl'
require 'csv'

secrets = YAML.load_file ('../../secrets.yml') # This file contains the twitter access information
key = secrets["PRODUCT_HUNT_ACCESS_TOKEN"]

start_days_ago = 0
max_days_ago = 352

# This array ensures that the location isn't collected of makers that have already been stored (increases speed)
maker_arr = Array.new

CSV.open( "results.csv", 'w' ) do |writer|

  for i in start_days_ago..max_days_ago
    response = HTTParty.get("https://api.producthunt.com/v1/posts/?access_token=#{key}&days_ago=#{i}")
    poster = response["posts"]

    poster.each do |post|
    	print = false
    	makers = post["makers"] 
    	if (makers.size > 0)
      	makers.each do |maker|
          # Only try to get the address if the maker hasn't already been checked
          if !maker_arr.include?(maker["username"]
            maker_arr << maker["username"]
            # Get the locations of the makers from Twitter if they have one listed       
          	begin
          		page = Nokogiri::HTML(open("https://twitter.com/" << maker["username"]))
          		address = page.css('span.ProfileHeaderCard-locationText.u-dir').text
          		add = address.downcase.gsub(/\s+/, "") #downcase and remove whitespace
          		
              # Ensure there is an address listed on the twitter
              if add.length > 2)
                puts "#{i} - Product Name: #{post["name"]}. Built by #{maker["username"]} in #{add}"
                writer << [i, post["name"], maker["username"], add]
              end

          	rescue
          		puts "Error"
        		end # /begin
          end
    		end # /makers.each
    	end # /id (makers.size > 0)
    end # /poster.each
  end
end