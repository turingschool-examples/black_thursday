require './lib/item'

class ItemRepository

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def all
    @items
  end

  def find_by_id(item_id)
    items.find do |item|
      item.id == item_id
    end
  end

  def find_by_name(item_name)
    items.find do |item|
      item.name == item_name
    end
  end

  def find_all_with_description(string_description)
    items.find_all do |item|
      item.description.downcase.include?(string_description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      item.unit_price_to_dollars > range.begin &&
      item.unit_price_to_dollars < range.max
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end
