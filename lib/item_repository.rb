require 'csv'
require_relative '../lib/item.rb'

class ItemRepository
  attr_reader :items
  def initialize(filepath)
    @filepath = filepath #"./data/items.csv"
    @items = [ ]
  end

  def create_items
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
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
    item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
    range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_id
    @items.max_by do |item|
      item.id
    end
  end

  def create_id
    find_highest_id.id.to_i + 1
  end

  def create(attributes)
    id = create_id
    attributes[:id] = id
    item = Item.new(attributes)
    @items << item
  end

  #def update


  #end

  def delete(id)
    item = find_by_id(id)
    @items.delete(item)
  end
end
