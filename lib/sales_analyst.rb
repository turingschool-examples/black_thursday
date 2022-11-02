require_relative 'sales_engine'
class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.length.to_f / engine.merchants.all.length).round(2)
  end

  def merch_hash
    hsh = engine.items.all.group_by do |item|
      item.merchant_id
    end
    hsh.map do |keys, values|
      hsh[keys] = values.count
    end
    hsh
  end

  def average_items_per_merchant_standard_deviation
    sqr_diff = 0.0
    merch_hash.each do |merchant, items|
      sqr_diff += (items - average_items_per_merchant)**2
    end
    std_dev = Math.sqrt((sqr_diff / (merch_hash.keys.count - 1)))
    std_dev.round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_specific_items = engine.items.find_all_by_merchant_id(merchant_id)
    merchant_total_value = merchant_specific_items.sum do |item|
      item.unit_price
    end
    merchant_total_value / merchant_specific_items.length
  end
end
