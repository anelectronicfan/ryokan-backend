class Property < ApplicationRecord

  def self.create_from_collection(properties)
    properties.each do |property_hash|
      Property.create(property_hash)
    end
  end



end
