require 'pry'
require_relative './sales_engine'
require_relative './mathable'
class SalesAnalyst
  include Mathable
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_items
    sales_engine.count_items
  end

  def total_merchants
    sales_engine.count_merchants
  end

  def average_item_price
    sales_engine.average_item_price
  end

  def average_items_per_merchant
    average_stuff(total_items.to_f, total_merchants)
  end

  def items_per_merchant
    sales_engine.items
  end

  def average_item_price
    sales_engine.average_item_price
  end

  def item_price_standard_deviation
    average = average_item_price
    total = sales_engine.pass_item_array.sum do |item|
      (average - item.unit_price_to_dollars)**2
      end
    square_something(total, total_items)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    total = 0
    sales_engine.merchant_hash_item_count.each do |key, value|
      total += (average - value)**2
    end
    square_something(total, total_merchants)
  end

  def merchants_with_high_item_count
    greater_than_sd = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants = []
    sales_engine.merchant_hash_item_count.find_all do |merchant_id, count|
      if count >= greater_than_sd
        merchants << sales_engine.find_by_merchant_id(merchant_id)
      end
    end
    merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.find_all_by_merchant_id(merchant_id)
    price_total = 0
    items.each do |item|
     price_total += item.unit_price
   end
    average_stuff(price_total , items.count)
  end

  def average_average_price_per_merchant
    averages = sales_engine.merchant_id_list.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    average_stuff(averages.sum, sales_engine.merchant_id_list.length)
  end

  def golden_items
    sales_engine.pass_item_array.find_all do |item|
      item.unit_price_to_dollars >= (sales_engine.average_item_price + (item_price_standard_deviation * 2))
    end
  end

  def total_invoices
    sales_engine.total_invoices
  end

  def average_invoices_per_merchant
    average_stuff(total_invoices.to_f, total_merchants)
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
    top_merchants = []
    invoice_hash = per_merchant_invoice_count_hash
    top_merchant_invoices = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    invoice_hash.each do |key, value|
      if value > top_merchant_invoices
        top_merchants << sales_engine.find_by_merchant_id(key)
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    invoice_hash = per_merchant_invoice_count_hash
    bottom_merchant_invoices = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    invoice_hash.each do |key, value|
      if value < bottom_merchant_invoices
        bottom_merchants << sales_engine.find_by_merchant_id(key)
      end
    end
    bottom_merchants
  end

  def average_invoices_per_day
    total_invoices / 7
  end

  def average_invoices_per_day_standard_deviation
    average = average_invoices_per_day
    per_day_invoice_hash = sales_engine.invoices_per_day
    total = 0
    per_day_invoice_hash.each do |key, value|
      total += (average - value)**2
    end
    # require "pry";binding.pry
    Math.sqrt(total / 6.00).round(2)
  end

  def top_days_by_invoice_count
    top_invoice_days = []
    minimum_for_top = average_invoices_per_day + (average_invoices_per_day_standard_deviation)
    invoice_hash = sales_engine.invoices_per_day
    invoice_hash.each do |key, value|
      if value > minimum_for_top
        top_invoice_days << key
      end
    end
    top_invoice_days
  end

  def invoice_status(status)
    all = sales_engine.invoices_per_status[status]
    ((all / total_invoices.to_f) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions_that_succeed = sales_engine.find_all_by_result(:success)
    transactions_that_succeed.any? do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def invoice_total(invoice_id)
    invoice_items = sales_engine.find_all_by_invoice_id(invoice_id)
    invoice_items.sum(0) do |invoice_item|
      if invoice_paid_in_full?(invoice_id)
        invoice_item.unit_price * invoice_item.quantity.to_i
      else
        0
      end
    end
  end

  def total_revenue_by_date(date)
    invoices = sales_engine.find_all_by_created_date(date)
    total = invoices.sum do |invoice|
      invoice_total(invoice.id)
    end
    BigDecimal(total).round(2)
  end

  def top_revenue_earners(count = 20)
    sorted_merchants = all_merchants_with_total_revenues.sort_by do |merchant_id|
      merchant_id[1]
    end.reverse
    top_merchant_ids = sorted_merchants[0...count]
    top_merchant_ids.map do |merchant_id|
      sales_engine.find_by_merchant_id(merchant_id[0])
    end
  end

  def all_merchants_with_total_revenues
    merchant_ids = sales_engine.create_merchant_id_hash
    merchant_totals = merchant_ids.reduce({}) do |acc, merchant_id|
      merchant_sum = merchant_id[1].sum do |invoice_id|
        invoice_total(invoice_id)
      end.round(2)
      acc[merchant_id[0]] = merchant_sum.to_f.round(2)
      acc
    end
    merchant_totals
  end

  def pending_invoices
    pending_invoices = sales_engine.find_all_by_status(:pending)
    shipped_invoices = sales_engine.find_all_by_status(:shipped)
    returned_invoices = sales_engine.find_all_by_status(:returned)
    merchant_ids = []

    pending_invoices.each do |invoice|
      merchant_ids << invoice.merchant_id if !invoice_paid_in_full?(invoice.id)
    end

    shipped_invoices.each do |invoice|
      merchant_ids << invoice.merchant_id if !invoice_paid_in_full?(invoice.id)
    end

    returned_invoices.each do |invoice|
      merchant_ids << invoice.merchant_id if !invoice_paid_in_full?(invoice.id)
    end

    merchant_ids.uniq
  end

  def merchants_with_pending_invoices
    pending_invoices_hold = pending_invoices
    pending_invoices_hold.map do |invoice|
      sales_engine.find_by_merchant_id(invoice)
    end
  end

  def find_ids_for_one_item
    merchant_hash = sales_engine.merchant_hash_item_count
    merchant_hash.find_all do |merchant, count|
      count == 1
    end
  end

  def merchants_with_only_one_item
    merchants = []
    ids_selling_one_item = find_ids_for_one_item
    ids_selling_one_item.each do |merchant, count|
      merchants << sales_engine.find_by_merchant_id(merchant)
    end
    merchants
  end

  def merchants_with_only_one_item_registered_in_month(month)
     x = Date::MONTHNAMES.index(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.month == x
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_and_rev_hash = all_merchants_with_total_revenues
    merchant_and_rev = []
    merchant_and_rev_hash.each do |merchant, total_rev|
      if merchant == merchant_id
        merchant_and_rev << total_rev
      end
    end
    merchant_and_rev[0].to_d
  end


end
