require_relative '../lib/item'

# item repo class
class ItemRepository
  attr_reader :items

  def initialize(csv_parsed_array)
    @items = create_index(csv_parsed_array)
  end

  def create_index(csv_data)
    csv_data.shift
    item_data = {}
    csv_data.each do |item|
      item_data[item[0]] = Item.new(item)
    end
    item_data
  end
end
