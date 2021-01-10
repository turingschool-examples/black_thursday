require_relative "item"
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"
require_relative 'repository_module'

class ItemRepository
  include Repository

  attr_reader :filename,
              :parent,
              :collection

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @collection = Array.new
    generate_items(filename)
  end

  # def inspect
  #   "#<#{self.class} #{@collection.size} rows>"
  # end

  def generate_items(filename)
    items = CSV.open filename, headers: true, header_converters: :symbol
    items.each do |row|
      @collection << Item.new(row, self)
    end
  end

  def find_all_with_description(description)
    @collection.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @collection.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @collection.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @collection.find_all do |item|
      item.merchant_id == merchant_id.to_s
    end
  end

  def create(attributes)
    attributes[:id] = highest_id_plus_one.to_s
    attributes[:unit_price]
    item = Item.new(attributes, self)
    @collection.push(item)
  end

  def update(id, attributes)
    update_item = find_by_id(id)
    update_item.update(attributes) if !attributes[:name].nil?
    update_item.update(attributes) if !attributes[:description].nil?
    update_item.update(attributes) if !attributes[:unit_price].nil?
    update_item
  end

  # def delete(id)
  #   delete = find_by_id(id)
  #   @collection.delete(delete)
  # end

end
