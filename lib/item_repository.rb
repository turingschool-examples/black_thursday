require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader :all

  def initialize(file)
    @all = []
    populate_item_repo(file)
  end

  def populate_item_repo(file)
    item_lines = CSV.open(file, headers: true, header_converters: :symbol)
    item_lines.each do |row|
      item = Item.new(row)
      all << item
    end
  end

  def add_items(item)
    all <<(item)
  end

  def find_by_id(id)
    all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    all.find do |item|
      item.name == name
    end
  end

  def find_all_with_descriptions(description_inc)
    all.find_all do |item|
      item.description.include?(description_inc)
    end
  end

  def find_all_by_price(unit_price)
    all.find_all do |item|
      item.unit_price_to_float == unit_price
    end
  end

  def find_all_by_price_in_range(price_range)
    all.find_all do |item|
      price_range.include?(item.unit_price_to_float)
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |id|
      id.merchant_id == merch_id
    end
  end
end
