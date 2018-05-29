require_relative 'merchantrepository.rb'
require_relative 'item.rb'
require 'bigdecimal'
require 'pry'
class SalesAnalyst

  def initialize(parent)
    @parent = parent
    @merchants = parent.merchants.merchants
    @items = parent.items.items
  end

  def average_items_per_merchant
    BigDecimal.new(@items.length.to_f / @merchants.length.to_f, 3).to_f
  end

  def group_items_by_merchant
    @items.group_by do |item|
      item.merchant_id
    end
  end

  def average_items_per_merchant_standard_deviation
    items_by_merchant = group_items_by_merchant
    average_items = average_items_per_merchant
    sum_of_squared_differences = items_by_merchant.inject(0) do |sum, merchant|
      difference = merchant[1].length - average_items
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@merchants.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 3).to_f
  end

  def merchants_with_high_item_count
    items_by_merchant = group_items_by_merchant
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    high_item_count = average_items + standard_deviation
    items_by_merchant.map do |merchant|
      if merchant[1].length > high_item_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end

  def average_items_for_merchant(id)
  end

  def average_average_per_merchant
  end

  def golden_items
  end

end
