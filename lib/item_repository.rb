require 'CSV'
require 'bigdecimal'
require_relative 'item'

class ItemRepository
  attr_reader :file_path, :all, :items, :id

  def initialize(file_path, engine)
    @file_path = file_path
    @engine = engine
  end

  def create_repo
    @items = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      item = Item.new(row, self)
      @items << item
    end
    self
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
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

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price_to_dollars == price
      #
       # require "pry"; binding.pry
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.cover?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    item_id = items.max { |item| item.id}
    attributes[:id] = item_id.id + 1
    @items << Item.new(attributes, self)
  end

  def update(id, attributes)
    item_by_id = find_by_id(id)
    if item_by_id != nil
      item_by_id.change_unit_price(attributes[:unit_price])
      item_by_id.update_time
    end
  end

  def delete(id)
    chopping_block = items.index { |item| item.id == id}
    if chopping_block != nil
      items.delete_at(chopping_block)
    end
  end
end
