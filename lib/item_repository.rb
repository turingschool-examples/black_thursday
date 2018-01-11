require 'csv'
require_relative '../lib/item'

class ItemRepository
  def initialize(file_path, parent)
    @items = []
    @sales_engine = parent
    item_data = CSV.open file_path, headers: true,
      header_converters: :symbol, converters: :numeric
    parse(item_data)
  end

  def parse(item_data)
    item_data.each do |row|
      @items << Item.new(row.to_hash, self)
    end
  end

  def all
    return @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_in_dollars == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @items.find_all do |item|
      price_range.cover?(item.unit_price_in_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    @sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
