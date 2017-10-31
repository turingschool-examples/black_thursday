# require 'csv'
require './lib/item'

class ItemRepository

  attr_reader :items, :parent

  def initialize(parent)
    @items = []
    @parent = parent
  end

  def count
    items.count
  end

  def create_item(data)
    items << Item.new(data, self)
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
      item.description.include?(description)
    end
  end

  def find_all_by_merchant_id(id)
    items.find_all do |merchant|
      merchant.merchant_id == id
    end
  end

end

#
# all - returns an array of all known Item instances
# find_by_id - returns either nil or an instance of Item with a matching ID
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied
