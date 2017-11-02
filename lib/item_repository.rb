require 'csv'
require_relative '../lib/item'

class ItemRepository

  attr_reader :items, :parent, :items_file

  def initialize(items_file, parent)
    @items = items_file.map {|item| Item.new(item, self)}
    @parent = parent
  end

  def count
    items.count
  end

  def merchant(id)
    parent.merchant(id)
  end

  def all
    return items
  end

  def find_by_id(id)
    items.find do |item|
      item.item_id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end

  end

  def find_all_by_merchant_id(id)
    items.find_all do |item|
      item.merchant_id.to_s == id.to_s
    end
  end

  def find_all_by_price(unit_price)
    items.find_all do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(low_price, high_price)
    items.find_all do |item|
      item.unit_price.between?(low_price, high_price)
    end
  end

end
