require "csv"
require "pry"
require 'time'
require_relative "find"
require_relative "modify"
require_relative "item"

class ItemRepository
include Find
include Modify
  attr_reader :items

  def initialize
    @items = []
  end

  def add(data)
    @items << Item.new(data)
  end

  def find_all_with_description(descrip)
    @items.find_all do |item|
      item.description.downcase.include?(descrip.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      item.unit_price.between?(range.first, range.last)
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end