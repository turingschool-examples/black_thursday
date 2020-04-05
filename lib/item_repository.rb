require 'csv'
require_relative '../lib/create_elements'
require_relative '../lib/item'
require 'pry'

class ItemRepository

  include CreateElements

  attr_reader :items, :engine

  def initialize(items_file, engine)
    @items = create_elements(items_file).map {|item| Item.new(item, self)}
    @engine = engine
  end

  def count
    items.count
  end

  def merchant(id)
    engine.merchant(id)
  end

  def all
    return items
  end

  def find_by_id(id)
    items.find do |item|
      item.id.to_i == id.to_i
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end

  end

  def find_all_by_merchant_id(id)
    items.find_all do |item|
      item.merchant_id == id
    end
  end

  def find_all_by_price(unit_price)
    items.find_all do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      (range).include?(item.unit_price)
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end
