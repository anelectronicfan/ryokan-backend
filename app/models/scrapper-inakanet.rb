require 'nokogiri'
require 'open-uri'
require 'pry'
require 'colorize'
require 'mechanize'





mechanize = Mechanize.new
page = mechanize.get('http://www.inakanet.jp/cgi-bin/database/database.cgi')

input = page.forms[0]

puts input