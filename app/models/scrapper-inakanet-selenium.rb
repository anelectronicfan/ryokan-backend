require 'pry'
require 'colorize'

require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.navigate.to "http://www.inakanet.jp/"
wait = Selenium::WebDriver::Wait.new(:timeout => 20)

name = wait.until {
  element_1 = driver.find_element(:class, "f13")
}
puts name.text

form = wait.until { 
  driver.find_element(:id, "bsearch")
}

button = form.find_element(:name, "submit2")

index = wait.until {
  button
}.click







