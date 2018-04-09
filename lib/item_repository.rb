require_relative '../lib/item'

# item repo class
class ItemRepository
  attr_reader :items

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |item|
      { id: item[0],
        name: item[1],
        description: item[2],
        unit_price: item[3],
        merchant_id: item[4],
        created_at: item[5],
        updated_at: item[6]
      }
    end
    @items = create_index(attributes)
  end

  def create_index(attributes)
    item_data = {}

    attributes.each do |attribute_set|
      item_data[attribute_set[:id]] = Item.new(attribute_set)
    end
    item_data
  end

  def all
    @items.values
  end

  def find_by_id(id)
    @items[id.to_s]
  end
end
