require 'csv'
require_relative 'item'
require 'pry'

class ItemRepository

  attr_reader :engine

  def initialize(filepath, parent = nil)
    @items    = []
    @engine   = parent
    load_items(filepath)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data, self)
    end
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @items.find_all { |item| item if range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all { |item| item.merchant_id == merchant_id }
  end

end
