require 'pry'
require 'bigdecimal'

class ItemRepository
  attr_reader       :items

  def initialize(items)
    @items = []
    items.each {|item| @items << Item.new(to_item(item))}
  end

  def to_item(item)
    item_hash = Hash.new
    item.each do |line|
      pair = line.split(":")
      item_hash[pair[0].to_sym] = pair[1]
      item_hash
    end
    item_hash[:id] = item_hash[:id].to_i
    item_hash[:unit_price] = item_hash[:unit_price].to_i
    item_hash[:merchant_id] = item_hash[:merchant_id].to_i
    item_hash
  end

  def unit_price_to_dollars
    @items
  end

end
