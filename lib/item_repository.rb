require_relative '../lib/item'
require 'csv'
require 'pry'

class ItemRepository

  attr_accessor :items

  def initialize(items = [])
      @items = items
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      id == item.id
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

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      (range).member?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id
    end
  end

  def create(attributes)
    item = Item.new(attributes)
    item.id = find_max_id + 1
    item.created_at = Time.now
    @items << item
  end

  def update(id, attributes)
    if find_by_id(id)
      item = find_by_id(id)
      if attributes[:name]
        item.name = attributes[:name]
      end
      if attributes[:description]
        item.description = attributes[:description]
      end
      if item.unit_price = attributes[:unit_price]
        item.unit_price  = attributes[:unit_price]
      end
      item.updated_at = Time.now
    end
  end

  def find_max_id
    max_id_item = @items.max_by do |item|
      item.id
    end
    max_id_item.id
  end

  def delete(id)
    item = find_by_id(id)
    @items.delete(item)
  end

  def inspect
     "#<#{self.class} #{@items.size} rows>"
  end
end
