require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'

# BUGS
#   - Not sure if actually exists or just a one off, but the scraper just scraped twice before trying to seed
#       - No wonder it took forever

# TODO:
#   - Error handling for timeouts
#       - Need to implement code to try the connection again
#       - OR extending the timeout threshold
#   - HALF: Refactoring opening urls into a helper function (error handling goes here)
#   - DONE: Add more console logs, like a timer or a percentage meter, definitely some kind of alert notification when completed
#   - DONE: Add support for pagination
#   - DONE: Modify for akiya-athome because akiya is dogwater
#   - DONE: There are at least three different layouts for the site that change 
#     ever so slightly, the positions of certain bits of key data 
#       - Need to figure out a more consistent approach
#       - Look into .bukken-data.detail-table[0] - appears more consistent 
#   - DONE: Fixed URI.open warning messages


class Scrapper

  ############### H E L P E R F U N C T I O N S ##############
  def scrape_property_urls(doc)
    # this method scrapes every listing url in a given page and returns an array of url strings
    
    properties = doc.css('section.propety')

    property_list_urls = []
    puts "Scraping #{properties.count} URLs".yellow #console logging for my own sanity

    properties.each do |property|
      url = property.css('a').first.attribute('href').value
      property_list_urls << url
      puts "#{property_list_urls.count}/#{properties.count}".yellow #console logging for my own sanity


    end
    puts "Scraped #{property_list_urls.count}/#{properties.count}".green #console logging for my own sanity

    property_list_urls
  end

  def format_property_hash(property_info)
    # This method should take a hash, and convert all values to their correct data type
    # according to the Property model schema, and return an updated hash
    
    
    updated_property = {
      address: property_info[:address].gsub(/[[:space:]]/, ''),
      price: property_info[:price].gsub(/[[:space:]]/, '').to_i * 10000,
      size: property_info[:size].gsub(/[[:space:]]/, '').chop.to_i,
      description: property_info[:description].gsub(/[[:space:]]/, ''),
      date_listed: property_info[:date_listed].gsub(/[[:space:]]/, ''),
      url: property_info[:url]
    }
    


    updated_property
  end

  def fetch(url)
    # Helper method that fetches and returns a webpage as nokogiri xml
    html = URI.open("#{url}/") # open is a open-uri method that takes a url and returns the content of its html source
  
    doc = Nokogiri::HTML(html) # HTML is a method from Nokogiri that takes an html and returns it as a set of nested nodes
    puts "Fetched #{url}".blue #console logging for my own sanity


    # TODO: Add error handling for timeouts
    doc
  end



  ############################################################


  ############## M A I N F U N C T I O N S ###################
  
  def scrape_prefecture_urls
    puts 'def scrape_prefecture_urls'.light_blue

    # This method will take an index page of prefectures and fetch each prefectures' url, storing them in an array

    akiya_url = 'https://www.akiya-athome.jp'
  
    doc = fetch(akiya_url)

    
    prefectures = doc.css('.governmentMap:not(.chugoku)').css('li').css('a') # doc.css is a method that uses the css selector to grab values of HTML elements as nodes, these can be chained together to retrieve specific values within nested nodes
  
    prefecture_urls = [] # empty array, this will store the url of each prefecture node
  
    prefectures.each do |prefecture|
      # This loop takes each prefecture node and stores their url into an array
      url = prefecture.attribute('href').value # only stores the href as "/area/location/""

      if url.include?('buy')
        url = "#{akiya_url}#{url}" # might need to move this line somewhere else if this becomes too slow
      
        prefecture_urls << url # short for prefecture_urls.push
      end
      # break # TODO: Remove this later, debug only
    end

    new_url = []
    
    for a in 1..(prefecture_urls.length/2) do
      new_url.push(prefecture_urls.pop)

    end
    #scrape_listing_urls(prefecture_urls)
    scrape_listing_urls(new_url)
    
  end

  def scrape_listing_urls(prefecture_urls)
    puts 'def scrape_listing_urls'.light_blue


    # this method loops through each prefecture, fetching every property it can find, and storing them as an array of html nodes

    # TODO: Support the edge case where no properties exist in a given prefecture
            # I.e skip this loop if properties don't exist
    property_list_urls = []

    prefecture_urls.each do |url|
      doc = fetch(url)

      # find total number of entries
      listing_count = doc.css('.count').css('.hit').children.first.text.to_i
      # find number of pages
      page_count = (listing_count.to_f / 20).ceil 
      
      # Scrape first page
      property_list_urls.concat(scrape_property_urls(doc))

      # loop through each page

      current_page = 2
      # page_count = 1 # TODO: Remove later, just for testing purposes
      if page_count > 2
        while current_page < page_count
          page_html = URI.open("#{url}#?br_kbn=buy&pref_cd=#{'%02d' % current_page}&page=1&search_sort=kokai_date&item_count=20")
          page_doc = Nokogiri::HTML(page_html)
  
          property_list_urls.concat(scrape_property_urls(page_doc))
  
          current_page += 1 
        end
      end
      

    end
    
    scrape_properties(property_list_urls)
  end

  def scrape_properties(property_list_urls)
    puts 'scrape_properties'.light_blue

    property_list = []
    property_list_urls.each do |url|
      doc = fetch(url)
      # details = doc.css('.bukken-data-detail.can-page-break-inside').css('.detail-table')
      details = doc.css('.bukken-data').css('.detail-table') 
      
      
      next if details == []
      table = details.at('table') # this returns the location of the first 'table' tag
      table << "<span id = 'url' >#{url}</span>"  # inserting the url in a span tag
                                                  # into the nodeSet to be passed on
      
      property_list << details
      puts "Scraped #{property_list.count}/#{property_list_urls.count} properties".yellow
    end
    create_properties(property_list)
  end
  
  def create_properties(property_list)
    puts 'def create_properties'.light_blue

    # this method takes every property node, finds relevant info and stores them into their own respective hashes. Returns a collection (array of hashes)
    
    properties = []
    puts "Creating #{property_list.count} properties".yellow #console logging for my own sanity

    property_list.each do |property|
      # size = ""
      # unless property[2].css('tr')[1].css('td')[1] # if size = nil, then find the size from somewhere else
      #   size = property[3].css('tr')[0].css('td')[0].children.first.text
      # else
      #   size = property[2].css('tr')[1].css('td')[1].children.first.text
      # end
      # address = property.first.css('tr')[1].css('td').children.first.text
      # price = property[1].css('tr')[0].css('td').children.first.text
      # description = property[0].css('tr')[0].css('td').children.text  
      
      
      address = property[0].css('tr')[1].css('td')[1].children.first.text
      price = property[0].css('span.price-red-strong').children.first.text
      size = property[0].css('tr')[2].css('td')[0].children.first.text
      if size.to_i == 0 || size.include?('年')
        # TODO: turn this shit into a switch statement
        # could've used a ternary, but this shit is already somewhat unreadable
        # might need a switch statement here instead
        # if there are more than 2 layouts where size is located
        size = property[0].css('tr')[2].css('td')[1].children.first.text
        if size.to_i == 0
          size = property[0].css('tr')[2].css('td')[2].children.first.text
        end
      end 
      description = property[0].css('tr')[1].css('td')[0].children.text
      date_listed = property.last.css('tr')[2].css('td').first.children.text
      url = property.css("#url").text
      
      property_info = {
        address: address,
        price: price,
        size: size,
        description: description,
        date_listed: date_listed,
        url: url
      }
      
      properties << format_property_hash(property_info)
      
      puts "Created #{properties.count}/#{property_list.count} Property hashes".yellow #console logging for my own sanity
      # binding.pry
    end
    puts " It's done now motherfuckers. Seeding next".green
    properties  # same as return properties
  end
  
end

########################################################################


# scrape = Scrapper.new
# scrape.scrape_prefecture_urls




