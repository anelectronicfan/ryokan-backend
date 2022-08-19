require 'nokogiri'
require 'open-uri'
require 'pry'

class Scrapper
  
  def scrape_prefecture_urls
    ieichiba_url = 'https://www.ieichiba.com/board'
  
    html = open(ieichiba_url) # open is a open-uri method that takes a url and returns the content of its html source
  
    doc = Nokogiri::HTML(html) # HTML is a method from Nokogiri that takes an html and returns it as a set of nested nodes
    
    prefectures = doc.css('.prefectures').css('dt').css('a') # doc.css is a method that uses the css selector to grab values of HTML elements as nodes, these can be chained together to retrieve specific values within nested nodes
  
    prefecture_urls = [] # empty array, this will store the url of each prefecture node
  
      prefectures.each do |prefecture|
        # This loop takes each prefecture node and stores their url into an array
        url = prefecture.attribute('href').value
        
        prefecture_urls << url # short for prefecture_urls.push
  
      end

    
  end

  binding.pry

    
end

scrape = Scrapper.new


