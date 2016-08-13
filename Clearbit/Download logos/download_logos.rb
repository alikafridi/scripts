require 'HTTParty'
require 'open-uri'
require 'json'
require 'openssl'
require 'csv'
require 'mechanize'

# Configure these params
file_name = "input.csv"

# Input handles from file name and push to twitter
CSV.foreach(file_name) do |row|
	begin
		agent = Mechanize.new
		link = "http://logo.clearbit.com/#{row[0]}"
		agent.get(link).save "images/#{row[0]}.jpg" 
	rescue
	end
end