require 'csv'
require './lib/item'
require 'pry'
require 'bigdecimal'

class ItemRepository
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def from_csv(file_path)
    raw_items_data = CSV.read(file_path, {headers: true, header_converters: :symbol})
    raw_items_data.map do |raw_item|
      Item.new(raw_item.to_h)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)

    @all.find_all do |item|
       item.unit_price_to_dollars >= price_range.first && item.unit_price_to_dollars <= price_range.last
    end
  end
end
