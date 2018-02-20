# frozen_string_literal: true

require 'csv'
require_relative 'item'

# Defines ItemRepository, holding a list of Items
class ItemRepository
  def initialize(filename)
    @items = []
    load_csv filename
  end

  def load_csv(filename)
    CSV.foreach(
      filename,
      headers: true,
      header_converters: :symbol
    ) do |item_info|
      item = Item.new item_info
      @items.push item
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.select do |item|
      id == item.id
    end.first
  end

  def find_by_name(name)
    name = name.downcase
    @items.select do |item|
      name == item.name.downcase
    end.first
  end

  def find_all_with_description(pattern)
    pattern = pattern.downcase
    @items.select do |item|
      item.description.downcase.include? pattern
    end
  end

  def find_all_by_price(price)
    @items.select do |item|
      price.eql? item.unit_price
    end
  end

  def find_all_by_price_in_range(range)
    @items.select do |item|
      range.include? item.unit_price.to_f * 100
    end
  end

  def find_all_by_merchant_id(id)
    @items.select do |item|
      id == item.merchant_id
    end
  end

  def inspect
    "#<#{self.class} #{@items.length} rows>"
  end
end
