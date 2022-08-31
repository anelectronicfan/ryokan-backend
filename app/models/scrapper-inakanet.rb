require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'
require 'mechanize'


# STEP 1:
# Make a scrapper for the first page
#   Use mechanize to parse the inakanet details page URL
#   Use css selectors to loop through every table (excluding the first two) in the body tag
#   During this loop, fetch property details and construct hashes for each
#   Push these hashes to a collection

# STEP 2:
# Use Mechanize to submit the next page form

# STEP 3:
# Loop step 1 and step 2 until the last page is scrapped

# STEP 4:
# Return the collection to be seeded


agent = Mechanize.new
html = agent.get('http://www.inakanet.jp/cgi-bin/database/database.cgi')

input = html.forms[0]

input['page'] = 2

new_page = input.submit

new_paged = Nokogiri::HTML(new_page)

puts new_paged.css('table')[2].css('td')[0].css('tr')[2].css('td')[1].children.text