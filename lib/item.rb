require 'bigdecimal'

class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at

  def initialize(item_information)
    @name = item_information[:name]
    @description = item_information[:description]
    @unit_price = item_information[:unit_price]
    @created_at = item_information[:created_at]
    @updated_at = item_information[:updated_at]
  end

end
