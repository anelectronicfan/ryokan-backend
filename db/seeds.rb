Property.destroy_all

scrape = Scrapper_ieichiba.new
properties = scrape.scrape_prefecture_urls
Property.create_from_collection(properties)
