# Frozen_string_literal: true

require 'CSV'
require_relative 'item'
# Item Repository
class ItemRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent)
    @contents = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents[row[:id]] = Item.new(row, self)
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_by_name(name)
    all.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(description)
    all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |item| item if item.merchant_id == merchant_id }
  end

  def create(attributes)
    max_id = @contents.max_by do |key, _|
      key
    end
    max = max_id[0].to_i + 1
    attributes[:id] = max
    @contents[:max] = Item.new(attributes, self)
  end

  def update(id, attributes)
    @contents[id] = attributes
  end

  def delete(id)
    @contents.delete(id)
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
