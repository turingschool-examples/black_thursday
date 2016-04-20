require './lib/item'
require_relative 'find'

class ItemRepository
  include Find

  attr_accessor :items

  def initialize
    @items = []
  end

  def <<(item_obj)
    @items.push(item_obj)
  end

  def all
    @items
  end

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_by_name(name)
    find_by_string({:name => name})
  end

  def find_all_with_description(partial)
    find_all_by_string_fragment({:description => partial})
  end

  def find_by_merchant_id(id)
    find_by_num({:merchant_id => id})
  end

  def find_all_by_price(price)
    tolerance = 0.0001
    @items.find_all do |item|
      (item.unit_price_to_dollars - price).abs <= tolerance
    end
  end

  def find_all_by_price_in_range(range)
    tolerance = 0.0001
    matches = @items.find_all do |item|
      item.unit_price_to_dollars >= (range.begin - tolerance) &&
      item.unit_price_to_dollars <= (range.end + tolerance)
    end
  end

end
