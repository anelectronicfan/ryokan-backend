require 'colorize'
class Property < ApplicationRecord

  def self.create_from_collection(properties)
    properties.each do |property_hash, i|
      Property.create(property_hash)
      puts "/nSeeded #{i + 1}/#{properties.count}/n".orange
    end
    puts "/n Done! #{Property.count} properties seeded! /n".green
  end



end
