require 'csv'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range === item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] ||= new_id(attributes)
    new_item = Item.new(attributes)
    @items << new_item
    new_item
  end

  def new_id(attributes)
    unless items.empty?
      attributes[:id] = all.max do |item|
        item.id
      end.id + 1
    end
  end

  def parse_data(file)
    rows = CSV.open file, headers: true, header_converters: :symbol
    rows.each do |row|
      new_obj = Item.new(row.to_h)
      items << new_obj
    end
  end

  def update(id, attributes)
    find_by_id(id).update(attributes) unless find_by_id(id).nil?
  end

  def delete(id)
    items.delete_if { |item| item.id == id }
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
