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


