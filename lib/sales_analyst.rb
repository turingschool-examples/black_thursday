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
    std_dev = Math.sqrt(sqr_diff / (merch_hash.keys.count - 1))
    std_dev.round(2)
  end

  def merchants_with_high_item_count
    high_merchants = []
    merch_hash.each do |merchant, items|
     if items - average_items_per_merchant_standard_deviation > average_items_per_merchant
      high_merchants << merchant
     end
    end
    high_merchants.map do |merchant_id|
      engine.merchants.find_by_id(merchant_id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_specific_items = engine.items.find_all_by_merchant_id(merchant_id)
    merchant_total_value = merchant_specific_items.sum do |item|
      item.unit_price
    end
    (merchant_total_value / merchant_specific_items.length).round(2)
  end

  def average_invoices_per_merchant
    (engine.invoices.all.length.to_f / engine.merchants.all.length).round(2)
  end
  
#helper method for average_invoices_per_merchant_standard_deviation
  def inv_hash
    inv_hsh = engine.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
      inv_hsh.map do |keys, values|
        inv_hsh[keys] = values.count
    end
    inv_hsh
  end

  def average_invoices_per_merchant_standard_deviation
    sqr_diff = 0.0
    # require 'pry'; binding.pry
    inv_hash.each do |merchant, number|
      sqr_diff += (number - average_invoices_per_merchant)**2
    end
    std_dev = Math.sqrt((sqr_diff / (inv_hash.keys.count - 1)))
    std_dev.round(2)
  end

  def avg_price_per_item
    arr = []
    engine.items.all.each do |item|
      arr << item.unit_price
    end
    arr.sum / arr.length
  end

  def average_item_price_standard_deviation
    sqr_diff = 0.0
    engine.items.all.each do |item|
      sqr_diff += (item.unit_price - avg_price_per_item)**2
    end
    std_dev = Math.sqrt(sqr_diff / (engine.items.all.count - 1))
    std_dev.round(2)
  end

  def golden_items
    min = avg_price_per_item + (average_item_price_standard_deviation * 2)
    max = 99999
    engine.items.find_all_by_price_in_range(min..max)
  end

  def average_average_price_per_merchant
    total_average_price = engine.merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (total_average_price / engine.merchants.all.length).round(2)
  end

  def invoice_status(status)
    total_by_status = engine.invoices.find_all_by_status(status)
    ((total_by_status.length.to_f / engine.invoices.all.length) * 100).round(2)
  end
end
