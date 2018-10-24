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

  def find_all_by_merchant_id(id)
    @items.select do |item|
      item.merchant_id == id
    end
  end

  def find_all_with_description(description) 
    @collection.find do |collection|
      collection.description == description
    end
  end

  def find_all_by_price(price) 
    @collection.find do |collection|
      collection.unit_price == price
    end
  end

end
