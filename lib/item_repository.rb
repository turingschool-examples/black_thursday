require_relative '../lib/item'
require 'csv'

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

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      (range).member?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all do |item|
      item.merchant_id == id.to_s
    end
  end

  def create(attributes)
    item = Item.new(attributes)
    item.id = (find_max_id + 1).to_s
    item.created_at = Time.now
    @items << item
  end

  def update(id, attributes)
    item             = find_by_id(id)
    item.name        = attributes[:name]
    item.description = attributes[:description]
    item.unit_price  = attributes[:unit_price].to_s.to_d
    item.updated_at  = Time.now
  end

  def find_max_id
    max_id_item = @items.max_by do |item|
      item.id
    end
    max_id_item.id.to_i
  end

  def delete(id)
    item = find_by_id(id)
    @items.delete(item)
  end
end
