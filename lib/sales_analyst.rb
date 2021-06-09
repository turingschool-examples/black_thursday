require 'date'
require_relative '../lib/modules/hashable'
require_relative '../lib/modules/countable'
require_relative '../lib/modules/calculatable'

class SalesAnalyst
  include Hashable
  include Countable
  include Calculatable

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    average_mean(@engine.items.all.length, @engine.merchants.all.length)
  end

  def average_items_per_merchant_standard_deviation
    average_standard_deviation(items_by_merch_count, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    merch_high_count = merch_items_hash.select do |merchant, items|
      items.length > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
    merch_high_count.keys
  end

  def price_of_items_for_merch(merchant_id)
    merch_items_hash[@engine.merchants.find_by_id(merchant_id)].map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(merchant_id)
    average_mean(price_of_items_for_merch(merchant_id).sum, price_of_items_for_merch(merchant_id).length)
  end

  def average_average_price_per_merchant
    avg_price_per_merch = merch_items_hash.keys.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (avg_price_per_merch.sum / avg_price_per_merch.length).floor(2)
  end

  def item_price_set
    @engine.items.all.map do |item|
      item.unit_price_to_dollars
    end
  end

  def average_price_per_item
    average_mean(item_price_set.sum, item_price_set.length)
  end

  def average_price_per_item_standard_deviation
    average_standard_deviation(item_price_set, average_price_per_item)
  end

  def golden_items
    @engine.items.all.select do |item|
      item.unit_price_to_dollars > (average_price_per_item +
        (2 * average_price_per_item_standard_deviation))
    end
  end

  def average_invoices_per_merchant
    average_mean(@engine.invoices.all.length, @engine.merchants.all.length)
  end

  def average_invoices_per_merchant_standard_deviation
    average_standard_deviation(invoices_by_merch_count, average_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    merch_high_count = merch_invoices_hash.select do |merch, invoices|
      invoices.length > (average_invoices_per_merchant +
        (2 * average_invoices_per_merchant_standard_deviation))
    end
    merch_high_count.keys
  end

  def bottom_merchants_by_invoice_count
    merch_low_count = merch_invoices_hash.select do |merch, invoices|
      invoices.length < (average_invoices_per_merchant -
        (2 * average_invoices_per_merchant_standard_deviation))
    end
    merch_low_count.keys
  end

  def pull_day_from_invoice
    dates = @engine.invoices.all.map do |invoice|
      invoice.created_at
    end
    dates.map do |date_stamp|
      date_stamp.wday
    end
  end

  def average_invoices_per_day
    average_mean(@engine.invoices.all.length.to_f, 7)
  end

  def avg_inv_per_day_std_dev
    average_standard_deviation(days_invoices_hash.values, average_invoices_per_day)
  end

  def invoice_status(invoice_status)
    invoices = @engine.invoices.all.select do |invoice|
      invoice.status.to_sym == invoice_status
    end
    ((invoices.length / @engine.invoices.all.length.to_f) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transaction = @engine.transactions.find_all_by_invoice_id(invoice_id)
    transaction.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    revenue_by_invoice_hash[@engine.invoices.find_by_id(invoice_id)]
  end

  def total_revenue_by_date(date)
    invoices = @engine.invoices.find_all_by_date(date).map do |invoice|
      invoice
    end
    invoices.sum do |invoice|
      revenue_by_invoice_hash[invoice]
    end
  end

  def top_revenue_earners(num = 20)
    sorted = revenue_by_merchant_hash.max_by(num) do |merch, rev|
      rev
    end
    merchant = sorted.map do |array|
      array[0]
    end
    merchant
  end

  def pending_invoices
    @engine.invoices.all.select do |invoice|
      invoice_paid_in_full?(invoice.id) == false
    end
  end

  def merchants_with_pending_invoices
    merchant_id = pending_invoices.map do |invoice|
      invoice.merchant_id
    end
    merchant_id.map do |merch_id|
      @engine.merchants.find_by_id(merch_id)
    end.uniq
  end

  def merchants_with_only_one_item
    merchants = []
    merchants_with_one_item_hash.each do |merch, item|
      merchants << merch
    end
    merchants
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merch_month = []
    merchants_with_one_item_hash.each do |merch, item|
      merch_month << merch if merch.created_at.month == month_to_number(month)
    end
    merch_month
  end

  def revenue_by_merchant(merch_id)
    revenue_by_merchant_hash[@engine.merchants.find_by_id(merch_id)]
  end

  def month_to_number(month)
    number = nil
    month_name_to_number_hash.each do |name, num|
      number = num if month == name
    end
    number
  end
end
