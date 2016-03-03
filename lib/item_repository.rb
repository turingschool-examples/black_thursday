require_relative '../sales_engine'
require_relative 'item'
require 'csv'
require 'bigdecimal'
require 'time'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(value_at_item)
    make_items(value_at_item)
  end

  def make_items(item_hashes)
    @items = []
    item_hashes.each do |item_hash|
      @items << Item.new(item_hash)
    end
    @items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |object| object.id == id.to_i }
  end

  def find_by_name(expected_name)
    @items.find { |object| object.name.downcase == expected_name.downcase }
  end

  def find_all_with_description(description_fragment)
    @items.find_all { |object| object.description.downcase.include?(description_fragment.downcase) }
  end

  def find_all_by_price(price)
    @items.find_all { |object| object.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |object|
      if range === object.unit_price
        @items
      end
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all { |object| object.merchant_id == id }
  end

end
