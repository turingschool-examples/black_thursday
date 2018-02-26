require 'csv'
require_relative 'item'
require_relative 'repository'

# Item Repo
class ItemRepository
  include Repository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @csv_items = []
    @engine   = parent
    load_children(filepath)
  end

  def items
    @csv_items
  end

  def child
    Item
  end

  def find_by_name(name)
    items.find { |item| item.name.casecmp(name.downcase).zero? }
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    items.find_all { |item| item if range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant_id == merchant_id }
  end

  def find_merchant_by_merchant_id(id)
    engine.find_merchant_by_merchant_id(id)
  end
end
