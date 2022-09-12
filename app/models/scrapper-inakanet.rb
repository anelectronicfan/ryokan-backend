require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'
require 'mechanize'


# STEP 1:
# Make a scrapper for the first page
#   Use mechanize to parse the inakanet details page URL


agent = Mechanize.new
front_page = agent.get('http://www.inakanet.jp/')
form = front_page.css('#bsearch').css('form').first
index = agent.click(form.css('table')[0].css('tr')[1].css('input')[0])
binding.pry





# table = doc.css('table')[2..] 
# #   Use css selectors to loop through every table (excluding the first two) in the body tag
# property_list = []

# table.each do |property|
#   binding.pry
#   address = property.css('tr')[1].css('tr')[9].css('tr')[0].css('td')[0].children.first.text
#   price = property.css('.price').children.first.text
#   size = property.css('tr')[1].css('tr')[9].css('tr')[3].css('td')[0].children.first.text
#   description = property.css('tr')[1].css('tr')[7].css('tr')[1].css('td')[0].children.first.text
#   date_listed = property.css('tr')[1].css('tr')[9].css('tr')[13].css('td')[0].children.first.text
#   url = 'no_urls_with_this_site'
  
#   property_info = {
#     address: address,
#     price: price,
#     size: size,
#     description: description,
#     date_listed: date_listed,
#     url: url
#   }
#   property_list << property_info

# end


#   During this loop, fetch property details and construct hashes for each
#   Push these hashes to a collection

# STEP 2:
# Use Mechanize to submit the next page form

# STEP 3:
# Loop step 1 and step 2 until the last page is scrapped

# STEP 4:
# Return the collection to be seeded