require 'CSV'
require_relative '../lib/item'
require 'pry'
require 'bigdecimal'
require 'time'

# class to hold the item repository

class ItemRepository
  attr_reader :items, :parent
  def initialize(filepath, parent)
    @items = []
    @parent = parent
    find_items(filepath)
  end

  def all
    @items
  end

  def find_items(filepath)
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

  def find_all_with_description(string)
    @items.find_all do |item|
      item.description.downcase.include?(string.downcase)
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
    @items.find_all do |item|
      item.merchant_id == id
    end
  end


  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def pass_merchant_id_to_se(id)
    @parent.pass_merchant_id_to_merchant_repo(id)
  end
end
