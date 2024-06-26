require 'nokogiri'
require 'open-uri'
require 'pry'

# TODO:
#   - Add support for pagination
#   - Modify for akiya-athome because ieichiba is dogwater


class OldScrapper_ieichiba
  
  def Oldscrape_prefecture_urls

    # This method will take an index page of prefectures and fetch each prefectures' url, storing them in an array

    ieichiba_url = 'https://www.ieichiba.com/board'
  
    html = open(ieichiba_url) # open is a open-uri method that takes a url and returns the content of its html source
  
    doc = Nokogiri::HTML(html) # HTML is a method from Nokogiri that takes an html and returns it as a set of nested nodes
    
    prefectures = doc.css('.prefectures').css('dt').css('a') # doc.css is a method that uses the css selector to grab values of HTML elements as nodes, these can be chained together to retrieve specific values within nested nodes
  
    prefecture_urls = [] # empty array, this will store the url of each prefecture node
  
      prefectures.each do |prefecture|
        # This loop takes each prefecture node and stores their url into an array
        url = prefecture.attribute('href').value # only stores the href as "/area/location/""
        url = "https://www.ieichiba.com#{url}" # might need to move this line somewhere else if this becomes too slow
        
        prefecture_urls << url # short for prefecture_urls.push
  
      end

    Oldscrape_listing_urls(prefecture_urls)
    
  end

  def Oldscrape_listing_urls(prefecture_urls)

    # this method loops through each prefecture, fetching every property it can find, and storing them as an array of html nodes

    property_list = []

    prefecture_urls.each do |url|
      html = open(url)
      doc = Nokogiri::HTML(html)

      properties = doc.css('div.property__list-item')
      
      properties.each do |property|
        property_list << property
      end
      
    end
    create_properties(property_list)
    
  end
  
  def create_properties(property_list)
    # this method takes every property node, finds relevant info and stores them into their own respective hashes. Returns a collection (array of hashes)

    properties = []
    property_list.each do |property|
      address = property.css('div.property__list-item-address').text
      price = 0 # placeholder value for now
      size = 0 # placeholder
      description = property.css('p.property__list-item-body').text
      built = 19990609 # placeholder
      
      property_info = {
        address: address,
        price: price,
        size: size,
        description: description,
        built: built
      }

      properties << property_info
      
    end
    
    properties  # same as return properties
  end
  
  

    
end




