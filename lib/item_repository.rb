require './lib/item'
require 'csv'

class ItemRepository
  attr_reader :items
  def initialize(file_path)
    @items = []
    load_csv(file_path)
  end


  def load_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric ) do |item|
      items<< Item.new(item.to_h)
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_by_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
end
