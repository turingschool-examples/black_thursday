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

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_id
    @items.max_by(&:id).id
  end

  def create(attributes)
    attributes[:id] = (find_highest_id+1)
    attributes[:created_at] = attributes[:created_at].to_s
    attributes[:updated_at] = attributes[:updated_at].to_s
    item = Item.new(attributes)
    @items << item
  end




  # def unit_price_to_dollars
  #   @items
  # end

end
