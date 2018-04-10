require 'pry'
require 'bigdecimal'
require_relative 'item'

class ItemRepository
  attr_reader       :items


  def initialize(items)
    @items = []
    items.each {|item| @items << Item.new(to_item(item))}
  end

  def to_item(item)
    item_hash = Hash.new
    item.each do |line|
      pair = line.split(": ")
      item_hash[pair[0].to_sym] = pair[1]
      item_hash
    end
    item_hash[:id] = item_hash[:id].to_i
    item_hash[:unit_price] = item_hash[:unit_price].to_i
    item_hash[:merchant_id] = item_hash[:merchant_id].to_i
    item_hash
  end

  def all
    @items
  end

  def find_by_id(number)
    @items.find do |item|
      item.id == number
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(letters)
    @items.find_all do |item|
      item.description.include?(letters)
    end
  end

  def unit_price_to_dollars
    @items
  end

end
