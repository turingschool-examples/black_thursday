require_relative '../lib/item'
require 'csv'
require 'pry'

class ItemRepository

  attr_reader :items

  def initialize(items_location)
      @items_location = items_location
      @items = []
      load_csv
  end

  def load_csv
    CSV.foreach(@items_location, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      id.to_s == item.id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      name.upcase == item.name.upcase
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.upcase.include?(description.upcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end
end
