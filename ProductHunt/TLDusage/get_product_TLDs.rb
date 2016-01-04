=begin
Author: Ali K. Afridi
Last Updated: 1/04/2015

This script goes through Product Hunt to get a list of all the TLDs of featured products
=end

require 'net/http'
require 'uri'
require 'HTTParty'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'openssl'
require 'csv'

secrets = YAML.load_file ('../../secrets.yml') # This file contains the twitter access information
key = secrets["PRODUCT_HUNT_ACCESS_TOKEN"]

start_days_ago = 2
max_days_ago = 150

maker_arr = Array.new

CSV.open( "results.csv", 'w' ) do |writer|
  for i in start_days_ago..max_days_ago
      puts "Days: #{i}"
      response = HTTParty.get("https://api.producthunt.com/v1/posts/?access_token=#{key}&days_ago=#{i}")
      poster = response["posts"]

      poster.each do |post|
        # figure out the TLD
        begin
          res = Net::HTTP.get_response(URI(post["redirect_url"]))
          url = res['location']

          # remove .php, .htm / .html, and .aspx in the urls since that messes up the algorithm
          url = url.gsub(".htm", "")
          url = url.gsub(".php", "")
          url = url.gsub(".aspx", "")
          puts url

          right = url.rindex(".")
          rightSide = url[right, url.length]
          tld = ""

          begin
            if (rightSide.include?('/'))
              tld = rightSide[0, rightSide.index('/')]
            elsif (rightSide.include?('?'))
              tld = rightSide[0, rightSide.index('?')]
            end
          end #/begin
          writer << [i, post["day"], post["name"], post["votes_count"], post["created_at"], url, tld]
        rescue
        end
      end # /poster.each
  end # for i in start_days_ago..max_days_ago
end # CSV.open