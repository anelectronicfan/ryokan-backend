require 'colorize'
class Property < ApplicationRecord

  def self.create_from_collection(properties)
    puts "Seeding...".yellow
    properties.each do |property_hash|
      Property.create(property_hash)
    end
    puts "Done! #{Property.count} properties seeded! ".green
    puts "Hope you enjoyed these two hours cunt ".green
  end



end
