require_relative 'math_methods'
require_relative 'merchant_analytics'
require_relative 'day_of_the_week_table'

class SalesAnalyst
  include MathMethods
  include MerchantAnalytics
  include DayTable
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def invoice_paid_in_full?(invoice_id)
    if invoice_result_table[invoice_id].nil?
      return false
    else
      invoice_result_table[invoice_id].any? do |transaction|
        transaction.result == :success
      end
    end 
  end

  def invoice_result_table
    @sales_engine.transactions.all.group_by do |transaction|
      transaction.invoice_id
    end
  end

  def invoice_total(invoice)
    invoice_totals = @sales_engine.invoice_items.all.map do |invoice_item|
      if invoice_item.invoice_id == invoice
        invoice_item.total_price
      end
    end
    BigDecimal(sum(invoice_totals.compact))
  end

  def average_items_per_merchant
    amount_of_items = @sales_engine.items.collection.length
    amount_of_merchants = @sales_engine.merchants.collection.length
    average(amount_of_items, amount_of_merchants)
  end

  def average_items_per_merchant_standard_deviation
    values = difference_between_number_and_mean_squared
    total = sum(values) / (values.length - 1)
    Math.sqrt(total).round(2)
  end

  def each_merchants_total_items
    @sales_engine.merchants.collection.values.map do |merchant|
      single_merchants_total_items(merchant.id)
    end
  end

  def difference_between_number_and_mean_squared
    each_merchants_total_items.map do |value|
      (value - average_items_per_merchant)**2
    end
  end

  def sum(numbers)
    numbers.reduce(0) do |collector, number|
      collector += number
      collector
    end
  end

  def single_merchants_total_items(desired_id)
    single_merchants_items(desired_id).length
  end

  def merchants_with_high_item_count
    deviation_above = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @sales_engine.merchants.collection.keys.inject([]) do |collector, merchant|
      if single_merchants_total_items(merchant) >= deviation_above
      collector << @sales_engine.merchants.collection[merchant]
      end
      collector
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = single_merchants_total_items(merchant_id)
    item_price_total = sum(item_prices_for_merchant(merchant_id))
    BigDecimal((item_price_total / merchant_items).round(2))
  end


  def item_prices_for_merchant(merchant_id)
    single_merchants_items(merchant_id).inject([]) do |collector, item|
      collector << item.unit_price
      collector
    end
  end

  def single_merchants_items(desired_id)
    @sales_engine.items.collection.values.find_all do |item|
      if item.merchant_id == desired_id
        item
      end
    end
  end

  def average_average_price_per_merchant
    collector = @sales_engine.merchants.collection.keys.map do |merchant|
      average_item_price_for_merchant(merchant)
    end
    BigDecimal((sum(collector)/collector.length).round(2))
  end

  def golden_items
    deviation_above = average_price_per_item_standard_deviation * 2
    @sales_engine.items.collection.values.inject([]) do |collector, item|
      if item.unit_price >= deviation_above
      collector << @sales_engine.items.collection[item.id]
      end
      collector
    end
    # binding.pry
  end

  def average_price_per_item_standard_deviation
    values = difference_between_item_price_and_mean_squared
    total = sum(values) / (values.length - 1)
    Math.sqrt(total).round(2)
    # binding.pry
  end

  def difference_between_item_price_and_mean_squared
    @sales_engine.items.collection.values.map do |value|
      (value.unit_price.to_f - average_price_per_item.to_f)**2
    end
  end

  def average_price_per_item
    collector = @sales_engine.items.collection.values.map do |item|
      item.unit_price
    end
    BigDecimal((sum(collector)/collector.length).round(2))
  end

  def average_invoices_per_merchant
    amount_of_invoices = @sales_engine.invoices.collection.length
    amount_of_merchants = @sales_engine.merchants.collection.length
    average(amount_of_invoices, amount_of_merchants)
  end

  def average_invoices_per_merchant_standard_deviation
    values = difference_between_merchant_invoices_and_mean_squared
    total = sum(values) / (values.length - 1)
    Math.sqrt(total).round(2)
  end

  def difference_between_merchant_invoices_and_mean_squared
    @sales_engine.merchants.collection.keys.map do |merchant|
      (single_merchants_total_invoices(merchant).to_f - average_invoices_per_merchant.to_f)**2
    end
  end

  def single_merchants_invoices(desired_id)
    @sales_engine.invoices.collection.values.find_all do |invoice|
      if invoice.merchant_id == desired_id
        invoice
      end
    end
  end

  def single_merchants_total_invoices(desired_id)
    single_merchants_invoices(desired_id).length
  end

  def top_merchants_by_invoice_count
    deviation_above = average_invoices_per_merchant + (average_items_per_merchant_standard_deviation * 2)
    @sales_engine.merchants.collection.keys.inject([]) do |collector, merchant_id|
      if single_merchants_total_invoices(merchant_id) >= deviation_above
      collector << @sales_engine.merchants.find_by_id(merchant_id)
      end
      collector
    end
  end

  def bottom_merchants_by_invoice_count
    deviation_below = average_invoices_per_merchant - (average_items_per_merchant_standard_deviation * 2)
    @sales_engine.merchants.collection.keys.inject([]) do |collector, merchant_id|
      if single_merchants_total_invoices(merchant_id) <= deviation_below
      collector << @sales_engine.merchants.find_by_id(merchant_id)
      end
      collector
    end
  end

  def top_days_by_invoice_count
    deviation_above = average_invoices_per_day + average_invoices_per_day_standard_deviation
    invoice_per_day_table.keys.inject([]) do |collector, day|
      if invoice_per_day_table[day] >= deviation_above
      collector << day
      end
      collector
    end
  end

  def average_invoices_per_day_standard_deviation
    values = difference_between_invoices_and_mean_squared
    total = sum(values) / (values.length - 1)
    Math.sqrt(total).round(2)
  end

  def difference_between_invoices_and_mean_squared
    invoice_per_day_table.values.map do |day|
      (day.to_f - average_invoices_per_day.to_f)**2
    end
  end

  def average_invoices_per_day
    amount_of_invoices = @sales_engine.invoices.collection.length
    average(amount_of_invoices, 7)
  end

  def invoice_status(desired_status)
    amount_of_invoices = @sales_engine.invoices.collection.length
    amount_of_invoices_matching_status = list_of_invoices_matching_status(desired_status).length
    ((amount_of_invoices_matching_status.to_f / amount_of_invoices.to_f) * 100).round(2)
  end

end
