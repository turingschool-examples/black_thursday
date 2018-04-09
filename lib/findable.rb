# Shared methods for searching repository classes
module Findable
  attr_reader :id
  attr_accessor :name

  def create_index(attributes)
    data = {}
    # TODO finish module stuff, differentiating between Merchant and Item instantiation

    attributes.each do |attribute_set|
      data[attribute_set[:id]] = Merchant.new(attribute_set)
    end
    data
  end  

end
