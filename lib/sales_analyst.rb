require 'pry'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    total = 0
    merchant_item_count.each do |key, value|
      total += (average - value)**2
    end
    Math.sqrt(total/(total_merchants - 1)).round(2)
  end

  def merchants_with_high_item_count
    greater_than_sd = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants = []
    merchant_item_count.find_all do |merchant_id, count|
      if count >= greater_than_sd
        merchants << sales_engine.merchants.find_by_id(merchant_id)
      end
    end
    merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    price_total = 0
    items.each do |item|
     price_total += item.unit_price
   end
    (price_total / items.count).round(2)
  end

  def average_average_price_per_merchant
    averages = merchant_id_list.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    (averages.sum / merchant_id_list.length).round(2)
  end

  def golden_items
    sales_engine.items.all.find_all do |item|
      item.unit_price_to_dollars >= (average_item_price + (item_price_standard_deviation * 2))
    end
  end

  def average_item_price
    price_total = sales_engine.items.all.sum do |item|
      item.unit_price_to_dollars
    end
    (price_total/ total_items).round(2)
  end

  def item_price_standard_deviation
    average = average_item_price
    total = sales_engine.items.all.sum do |item|
      (average - item.unit_price_to_dollars)**2
    end
    Math.sqrt(total/(total_items - 1)).round(2)
  end

  def merchant_id_list
    merchant_id_list = []
    sales_engine.items.all.each do |item|
      merchant_id_list << item.merchant_id
    end
    merchant_id_list.uniq
  end

  def merchant_item_count
    sales_engine.items.all.reduce({}) do |acc, item|
      merchant_item_count = sales_engine.items.find_all_by_merchant_id(item.merchant_id).length
      acc[item.merchant_id] = merchant_item_count
      acc
    end
  end

  def total_items
    sales_engine.items.all.length
  end

  def total_merchants
    sales_engine.merchants.all.length
  end

  def total_invoices
    sales_engine.total_invoices
  end

  def average_invoices_per_merchant
    (total_invoices.to_f / total_merchants).round(2)
  end

  def per_merchant_invoice_count_hash
    @invoice_hash = sales_engine.per_merchant_invoice_count_hash
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    invoice_hash = per_merchant_invoice_count_hash
    total = 0
    invoice_hash.each do |key, value|
      total += (average - value)**2
    end
    Math.sqrt(total/(total_merchants - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchant_ids = []
    invoice_hash = per_merchant_invoice_count_hash
    top_merchant_invoices = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    invoice_hash.each do |key, value|
      if value > top_merchant_invoices
        top_merchant_ids << key
      end
    end
    top_merchant_ids
  end

  def bottom_merchants_by_invoice_count
    bottom_merchant_ids = []
    invoice_hash = per_merchant_invoice_count_hash
    bottom_merchant_invoices = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    invoice_hash.each do |key, value|
      if value < bottom_merchant_invoices
        bottom_merchant_ids << key
      end
    end
    bottom_merchant_ids
  end

  def average_invoices_per_day
    total_invoices / 7 
  end

  def top_days_by_invoice_count

  end
end
