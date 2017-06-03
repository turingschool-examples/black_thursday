require_relative './sales_engine'

class SalesAnalyst

  attr_reader :se
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    mr = se.merchants.all
    ir = se.items.all

    average = (ir.length.to_f)/(mr.length)
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    keys = create_items_per_merchant_hash.keys
    values = create_items_per_merchant_hash.values
    mean = values.reduce(:+)/values.length.to_f
    mean_squared = values.reduce(0) { |acc, num| acc += ((num - mean)**2) }
    Math.sqrt(mean_squared / (values.length - 1)).round(2)
  end

  def create_items_per_merchant_hash
    merchant_items = {}
    mr = se.merchants.all
    mr.each do |merchant|
      items = se.items_by_merchant_id(merchant.id)
      merchant_items[merchant.id] = items.length
    end
    merchant_items
  end

  def merchants_with_high_item_count
    mr = se.merchants.all
    one_deviation = average_items_per_merchant + average_items_per_merchant_standard_deviation
    mr.find_all do |merchant|
      merchant.items.length >= one_deviation
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = se.items_by_merchant_id(merchant_id)
    sum = 0
    items.each do |item|
      sum += item.unit_price
    end
    # price_sum = items.reduce(0) {|acc, item| acc += item.unit_price}
    price_average = sum.to_f/(items.length)
    price_average.round(2)
  end

end
