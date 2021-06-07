require 'date'
require_relative '../lib/modules/hashable'
require_relative '../lib/modules/countable'
require_relative '../lib/modules/calculatable'
require 'pry'

class SalesAnalyst
  include Hashable
  include Countable
  include Calculatable

  def initialize(engine)
    @engine = engine
  end
###### Average Mean
  def average_items_per_merchant
    average_mean(@engine.items.all.length, @engine.merchants.all.length)
    # (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    average_mean(price_of_items_for_merch(merchant_id).sum, price_of_items_for_merch(merchant_id).length)
  end

  def average_price_per_item
    average_mean(item_price_set.sum, item_price_set.length)
  end

  def average_invoices_per_merchant
    average_mean(@engine.invoices.all.length, @engine.merchants.all.length)
  end

  def average_invoices_per_day
    average_mean(@engine.invoices.all.length.to_f, 7)
  end
######
###### Standard Deviation Mean
  def average_items_per_merchant_standard_deviation
    average_standard_deviation(items_by_merch_count, average_items_per_merchant)
  end

  def average_price_per_item_standard_deviation
    average_standard_deviation(item_price_set, average_price_per_item)
  end

  def average_invoices_per_merchant_standard_deviation
    average_standard_deviation(invoices_by_merch_count, average_invoices_per_merchant)
  end

  def avg_inv_per_day_std_dev
    numerator = days_invoices_hash.values.sum do |num|
      (num - average_invoices_per_day) ** 2
    end
    average_invoices_per_day_std_dev = Math.sqrt(numerator / 6.0).round(2)
  end
######
  def return_merch_obj(merch_id)
    @engine.merchants.all.select do |merchant|
      merch_id.include?(merchant.id)
    end
  end

  def merchants_with_high_item_count
    merch_high_count = merch_items_hash.select do |merch_id, items|
      items.length > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
    return_merch_obj(merch_high_count)
  end

  def price_of_items_for_merch(merchant_id)
    merch_items_hash[merchant_id].map do |item|
      item.unit_price
    end
  end

  def average_average_price_per_merchant
    avg_price_per_merch = merch_items_hash.keys.map do |id|
      average_item_price_for_merchant(id)
    end
    (avg_price_per_merch.sum / avg_price_per_merch.length).floor(2)
  end

  def item_price_set
    @engine.items.all.map do |item|
      item.unit_price_to_dollars
    end
  end

  def golden_items
    @engine.items.all.select do |item|
      item.unit_price_to_dollars > (average_price_per_item +
        (average_price_per_item_standard_deviation * 2))
    end
  end

  def invoices_by_merch_count
    count = merch_invoices_hash.values.map do |invoice_array|
      invoice_array.count
    end
    count
  end

  def top_merchants_by_invoice_count
    merch_high_count = merch_invoices_hash.select do |merch_id, invoices|
      invoices.length > (average_invoices_per_merchant + (2 * average_invoices_per_merchant_standard_deviation))
    end
    merch_high_count.keys.map do |merch_id|
      @engine.merchants.find_by_id(merch_id)
    end
  end

  def bottom_merchants_by_invoice_count
    merch_high_count = merch_invoices_hash.select do |merch_id, invoices|
      invoices.length < (average_invoices_per_merchant + (2 * average_invoices_per_merchant_standard_deviation))
    end
    merch_high_count.keys.map do |merch_id|
      @engine.merchants.find_by_id(merch_id)
    end
  end

  def pull_day_from_invoice
    dates = @engine.invoices.all.map do |invoice|
      invoice.created_at
    end
    dates.map do |date_stamp|
      date_stamp.wday
    end
  end

  def top_days_by_invoice_count
    days_high_count = days_invoices_hash.select do |days, invoices|
      invoices > (average_invoices_per_day + avg_inv_per_day_std_dev)
    end
    days_high_count.keys
  end

  def invoice_status(invoice_status)
    invoices = @engine.invoices.all.select do |invoice|
      invoice.status.to_sym == invoice_status
    end
    ((invoices.length / @engine.invoices.all.length.to_f) * 100).round(2)
  end

########## Iteration 4
  def invoice_id_with_successful_payments
    @engine.transactions.find_all_by_result(:success).map do |transaction|
      transaction.invoice_id
    end
  end

  def pending_invoices
    @engine.invoices.all.select do |invoice|
      !invoice_id_with_successful_payments.include?(invoice.id)
    end
  end

  def total_revenue_by_date(date)
    invoice_ids = @engine.invoices.find_all_by_date(date).map do |invoice|
      invoice.id
    end
    invoice_ids.sum do |id|
      revenue_by_invoice_hash[id]
    end
  end

  def top_revenue_earners(num)
    sorted = revenue_by_merchant_id_hash.max_by(2) do |merch, rev|
      rev
    end
    merch_id = sorted.map do |array|
      array[0]
    end
    return_merch_obj(merch_id)
  end


  def top_revenue_earners
    sorted = revenue_by_merchant_id_hash.max_by(20) do |merch, rev|
      rev
    end
    merch_id = sorted.map do |array|
      array[0]
    end
    return_merch_obj(merch_id)
  end

  def merchants_with_pending_invoices
    merchant_id = pending_invoices.map do |invoice|
      invoice.merchant_id
    end
    return_merch_obj(merchant_id)
  end

  def merchants_with_only_one_item
    merchants = []
    merch_items_hash.each do |merch, item|
      merchants << merch if item.count == 1
    end
    return_merch_obj(merchants)
  end

  def merchants_with_only_one_item_registered_in_month(month)
    num = month_to_num_hash.find do |name, num|
      month == name
    end
  end
end
