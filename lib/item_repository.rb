# Frozen_string_literal: true

require 'CSV'
require_relative 'item'
require_relative 'repository'
# Item Repository
class ItemRepository
  attr_reader :contents,
              :parent

  include Repository

  def initialize(path, parent)
    @contents = {}
    @parent = parent
    load_path(path)
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
    max_id = @contents.keys.max + 1
    attributes[:id] = max_id
    attributes[:created_at] = Time.now
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
