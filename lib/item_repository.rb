require 'csv'
require_relative 'item'

class ItemRepository
  attr_accessor :items
  attr_reader   :sales_engine

  def initialize(items_data, sales_engine)
    @items = items_data.map do |item_data|
      Item.new(item_data, self)
    end
    @sales_engine = sales_engine
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id.to_i
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    descriptions = items.select do |item|
      item.description.downcase.include? description.downcase
    end
    descriptions
  end

  def find_all_by_price(price)
    prices = items.select do |item|
      item.unit_price_to_dollars == price
    end
    prices
  end

  def find_all_by_price_in_range(price)
    prices = items.select do |item|
      price.include?(item.unit_price_to_dollars)
    end
    prices
  end

  def find_all_by_merchant_id(merch_id)
    merchant_id = items.select do |item|
      item.merchant_id == merch_id
    end
    merchant_id
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
