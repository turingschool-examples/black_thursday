require './lib/repository'

class ItemRepository < Repository

  def initialize
    @collection = {}
  end

  def add_item(item)
    @collection[item.id] = item
  end

  def items
    @collection.values
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_item(Item.new(attributes))
  end

  def find_all_by_price_in_range(range)
    @collection.values.select do |item|
      item.unit_price >= range.min && item.unit_price <= range.max
    end
  end

  def find_all_by_merchant_id(id)
    @collection.values.select do |item|
      item.merchant_id == id
    end
  end

  def find_all_with_description(description)
    @collection.values.find do |collection|
      collection.description == description
    end
  end

  def find_all_by_price(price)
    @collection.values.find_all do |collection|
      collection.unit_price == price
    end
  end

end
