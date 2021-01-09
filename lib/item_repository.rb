require_relative "item"
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"

class ItemRepository
  attr_reader :filename,
              :parent,
              :items

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @items = Array.new
    generate_items(filename)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def generate_items(filename)
    items = CSV.open filename, headers: true, header_converters: :symbol
    items.each do |row|
      @items << Item.new(row, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id.to_i == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase == description.downcase
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
      item.merchant_id == merchant_id.to_s
    end
  end

  def create(attributes)
    id = @items[-1].id.to_i
    id += 1
    id = id.to_s
    attributes[:id] = id
    attributes[:unit_price]
    item = Item.new(attributes, self)
    @items.push(item)
  end

  def update(id, attributes)
    update_item = find_by_id(id)
    update_item.update(attributes) if !attributes[:name].nil?
    update_item.update(attributes) if !attributes[:description].nil?
    update_item.update(attributes) if !attributes[:unit_price].nil?
    update_item
  end

  def delete(id)
    delete = find_by_id(id)
    @items.delete(delete)
  end

end