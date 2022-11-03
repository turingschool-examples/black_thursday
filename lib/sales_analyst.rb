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
    sqr_diff = merch_hash.sum do |merchant, items|
      (items - average_items_per_merchant)**2.0
    end
    Math.sqrt(sqr_diff / (merch_hash.keys.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    merch_hash.filter_map do |merchant, items|
     next if items - average_items_per_merchant_standard_deviation < average_items_per_merchant
     engine.merchants.find_by_id(merchant)
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
    sqr_diff = inv_hash.sum do |merchant, number|
      (number - average_invoices_per_merchant)**2.0
    end
    Math.sqrt((sqr_diff / (inv_hash.keys.count - 1))).round(2)
  end

  def avg_price_per_item
    engine.items.all.sum { |item| item.unit_price} / engine.items.all.length
  end

  def average_item_price_standard_deviation
    sqr_diff = engine.items.all.sum do |item|
      (item.unit_price - avg_price_per_item)**2.0
    end
    Math.sqrt(sqr_diff / (engine.items.all.count - 1)).round(2)
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

  def average_invoices_per_day
    engine.invoices.all.length.to_f / 7
  end

  def day_hash
    day_hsh = engine.invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
    day_hsh.map do |keys, values|
      day_hsh[keys] = values.count
    end
    day_hsh
  end

  def average_invoices_per_day_standard_deviation
    sqr_diff = day_hash.sum do |day, number|
      (number - average_invoices_per_day)**2.0
    end
    Math.sqrt((sqr_diff / 6)).round(2)
  end

  def top_merchants_by_invoice_count
    inv_hash.filter_map do |merchant, amount|
      next if ((average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant) > amount
      @engine.merchants.find_by_id(merchant)
    end
  end

  def bottom_merchants_by_invoice_count
    inv_hash.filter_map do |merchant, amount|
      # require 'pry'; binding.pry
      next if (average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2) < amount
      @engine.merchants.find_by_id(merchant)
    end
  end

  def top_days_by_invoice_count
    day_hash.filter_map do |day, amount|
      day if amount > (average_invoices_per_day + average_invoices_per_day_standard_deviation)
    end
  end
end

# merch_hash.filter_map do |merchant, items|
#   next if items - average_items_per_merchant_standard_deviation < average_items_per_merchant
#   engine.merchants.find_by_id(merchant)