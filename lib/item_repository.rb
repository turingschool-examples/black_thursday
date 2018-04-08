require 'csv'
require_relative 'item'
class ItemRepository
  attr_reader :items

  def initialize(filepath)
    @items = []
    find_items(filepath)
  end

  def find_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(item_description)
    @items.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all { |item| item.merchant_id == id }
  end
end
