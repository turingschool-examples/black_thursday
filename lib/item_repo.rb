require_relative 'item'
require 'csv'
require 'pry'

class ItemRepository
  attr_reader :engine, :contents

  def initialize(csvfile, engine)
    @engine = engine
    @contents  = load_items(csvfile)
  end

  def load_items(csvfile)
    contents = CSV.open csvfile, headers: true, header_converters: :symbol
    all_items = {}
    contents.each do |row|
      all_items[row[:id]] = Item.new(row, self)
    end
    all_items
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id.to_s]
  end

  def find_by_name(name)
    content_array = all
    content_array.find do |item|
      if item.name == name
        return item
      end
    end
  end

  def find_all_with_description(description)
    content_array = all
    content_array.find_all do |item|
      if item.description == description
        return item
      end
    end
  end

  def find_all_by_price(price)
    content_array = all
    content_array.find_all do |item|
      if item.unit_price == price
        return item
      end
    end
  end

  def find_all_by_price_in_range(range)
    content_array = all
    content_array.find_all do |item|
      if item.unit_price < range.end && item.unit_price > range.begin
        return item
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    content_array = all
    content_array.find_all do |item|
      if item.merchant_id == merchant_id
        return item
      end
    end
  end

end
