# frozen_string_literals: true

require 'bigdecimal'
require_relative 'repository'
require_relative 'item'

# ./lib/item_repository
class ItemRepository
  include Repository
  attr_reader :items

  def initialize
    @items = []
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def all
    @items
  end

  def find_all_with_description(partial_description)
    @items.find_all do |item|
      item_description = item.description.downcase
      item_description.include?(partial_description.downcase)
    end
  end

  def find_all_by_price(search_price)
    @items.find_all { |item| item.unit_price == search_price }
  end

  def find_all_by_price_in_range(search_price_range)
    @items.find_all do |item|
      search_price_range.cover?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(search_id)
    @items.find_all { |item| item.merchant_id == search_id }
  end

  def create_with_id(attributes)
    @items << Item.new(attributes)
  end

  def child_class
    Item
  end

  def create(attributes)
    all << child_class.create(attributes)
  end

  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?
    item.name = attributes[:name] unless attributes[:name].nil?
    item.description = attributes[:description] unless attributes[:description].nil?
    item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    item.updated_at = Time.now
  end
# ----------------------------------------------------------------------

  def number_of_merchants
    group_item_by_merchant_id.keys.count
  end

  def group_item_by_merchant_id
    @items.group_by { |item| item.merchant_id }
  end

  def average_items_per_merchant
    (@items.size / number_of_merchants.to_f).round(2)
  end

  def mean_item_price
    total = @items.inject(0) {|sum, item| sum += item.unit_price }
    total / @items.count
  end

  def average_item_price_for_merchant(id)
     grouped_hash = group_item_by_merchant_id
     item_count = grouped_hash[id].size
     item_value_total = grouped_hash[id].inject(BigDecimal.new(0)) do |total, item|
       total += item.unit_price
     end
     average = (item_value_total / BigDecimal.new(item_count))
     average.round(2)
  end

  def average_average_price_per_merchant
    grouped_hash = group_item_by_merchant_id
    merchant_count = grouped_hash.keys.size
    sum = grouped_hash.inject(BigDecimal.new(0)) do |total, hash_array|
      total += average_item_price_for_merchant(hash_array[0])
    end
    average = sum / merchant_count
    average.round(2)
  end
end
