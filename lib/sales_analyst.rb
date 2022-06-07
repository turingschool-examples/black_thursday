require './lib/sales_engine'
require 'BigDecimal'

class SalesAnalyst
  def initialize(items_path, merchant_path)
    @items_path = items_path
    @merchant_path = merchant_path
  end

  def merchant_hash
    merchants_items_hash = @items_path.all.group_by do |item|
      item.merchant_id
    end
    merchants_items_hash.map do |keys, values|
      merchants_items_hash[keys] = values.count
    end
    merchants_items_hash
  end

  def average_items_per_merchant
    merchants = merchant_hash.keys.count
    items = merchant_hash.values.sum.to_f
    average_per = (items.to_f / merchants.to_f).round(2)
    average_per
  end

  def average_items_per_merchant_standard_deviation
    squared_differences = 0.0
    merchant_hash.each do |merchant, items|
      squared_differences += (items - average_items_per_merchant)**2
    end
    stdev = (squared_differences / (merchant_hash.keys.count - 1))**0.5
    stdev.round(2)
  end

  def merchants_with_high_item_count
    high_rollers = []
    merchant_hash.each do |key, value|
      if value >= average_items_per_merchant_standard_deviation + 1
        high_rollers << key
      end
      high_rollers
    end
  end

  def average_item_price_for_merchant(merchant_id_search)
    items_to_avg = @items_path.find_all_by_merchant_id(merchant_id_search)
    total_price = BigDecimal("0")
    items_to_avg.each do |item|
      total_price += item.unit_price
    end
    average_price = (total_price / items_to_avg.count)
  end

  def average_average_price_per_merchant
    average_price_array = []
    @merchant_path.all.each do |merchant|
      average_price_array << average_item_price_for_merchant(merchant.id)
    end
    average_average_price = (average_price_array.sum / average_price_array.count)
  end
end
