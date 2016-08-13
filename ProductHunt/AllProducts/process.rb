require 'HTTParty'
require 'open-uri'
require 'json'
require 'openssl'
require 'csv'


CSV.open("processed.csv", 'w') do |writer|
	writer << ["day", "name", "tagline", "tagline_length", "votes_count", "comments_count", "exclusive?", "featured?", "maker_inside", "hunter_id", "hunter_twitter_username", "platforms", "topics", "num_of_makers" ]
	CSV.foreach("allProducts.csv") do |row|

		writer << [row[8], row[4], row[6], row[6].length, row[20], row[7], row[10], row[11], row[12], row[18], row[19], row[14], row[15]]

	end # CSV.open
end


#[13 ==> post["makers"]]