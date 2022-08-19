Property.destroy_all

scrape = Scrapper.new
properties = scrape.scrape_prefecture_urls
Property.create_from_collection(properties)
