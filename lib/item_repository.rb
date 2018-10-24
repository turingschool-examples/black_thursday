require './lib/repository'

class ItemRepository < Repository
  attr_reader :items

  def initialize
    @items = []
    @collection = @items
  end

  def add_item(item)
    @items << item
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_item(Item.new(attributes))
  end

  def find_all_by_price_in_range(range)
    @items.select do |item|
      item.unit_price >= range.min && item.unit_price <= range.max
    end
  end

  # find_all_with_description(description) - Jennica
  # find_all_by_price(price) - Jennica
  # find_all_by_price_in_range(range) - Justin
  # find_all_by_merchant_id(merchant_id) - Justin

end
