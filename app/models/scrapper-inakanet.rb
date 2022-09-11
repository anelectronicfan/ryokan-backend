require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'
require 'mechanize'


# STEP 1:
# Make a scrapper for the first page
#   Use mechanize to parse the inakanet details page URL


agent = Mechanize.new
doc = agent.get('http://www.inakanet.jp/cgi-bin/database/database.cgi')
table = doc.css('table')[2..] 
#   Use css selectors to loop through every table (excluding the first two) in the body tag
property_list = []

table.each do |property|
  address = property[0].css('tr')[1].css('tr')[9].css('tr')[0].css('td')[0].children.first.text
  price = property[0].css('.price').children.first.text
  size = property[0].css('tr')[1].css('tr')[9].css('tr')[3].css('td')[0].children.first.text
  description = property[0].css('tr')[1].css('tr')[7].css('tr')[1].css('td')[0].children.first.text
  date_listed = property[0].css('tr')[1].css('tr')[9].css('tr')[13].css('td')[0].children.first.text
  url = 'no_urls_with_this_site'
  
  property_info = {
    address: address,
    price: price,
    size: size,
    description: description,
    date_listed: date_listed,
    url: url
  }

end

binding.pry

#   During this loop, fetch property details and construct hashes for each
#   Push these hashes to a collection

# STEP 2:
# Use Mechanize to submit the next page form

# STEP 3:
# Loop step 1 and step 2 until the last page is scrapped

# STEP 4:
# Return the collection to be seeded