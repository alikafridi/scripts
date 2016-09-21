=begin
Takes a bunch of keywords (separate lines in input.csv) and opens in browser
showing the term in the Moz Keyword tool. 
=end

require 'csv'
start = 0
ends = 0

i = 0

CSV.foreach("input.csv") do |row|
	row[0].gsub!(' ', '+')
	url_string = "https://moz.com/explorer/overview?q=#{row[0]}"
  if (i >= start && i <= ends)
  	system('open', url_string)
  end
  i = i + 1
end