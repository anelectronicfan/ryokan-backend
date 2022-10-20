require 'uri'
require 'net/http'
require 'openssl'

class Translator

  def translate(query)
    ## This method returns a given string translated via google
  url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Post.new(url)
  request["content-type"] = 'application/x-www-form-urlencoded'
  request["Accept-Encoding"] = 'application/gzip'
  request["X-RapidAPI-Key"] = '99b0486bf4mshdb2eba82834eb06p18b283jsne4361d51874f'
  request["X-RapidAPI-Host"] = 'google-translate1.p.rapidapi.com'
  request.body = "q=#{query}&format=text&target=en&source=ja"

  response = http.request(request)
  return response.read_body
  end

  def translate_property(property)
    ## This method translates a property model
    

  end

  def translate_properties(collection, quantity = 'default')
    ## This method translates a collection of properties
    if quantity == 'default'
      quantity = collection.count
    end
    
  end
  
end

translating = Translation.new
puts translating.translate('北海道夕張郡栗山町字中里25番地62')