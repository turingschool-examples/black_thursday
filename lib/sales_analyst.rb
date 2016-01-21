require_relative 'sales_engine'
require_relative 'merchant_analysis'
require          'pry'
require          'pry'
require 'time'

class SalesAnalyst
  include MerchantAnalysis
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def number_of_items
    se.items.all.count
  end

  def average_items_per_merchant
    se.merchants.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(se.merchants.variance_items).round(2)
  end

  def merchants_with_high_item_count
    benchmark = one_standard_dev_above_mean_value
    se.merchants.all.find_all { |merchant|
       merchant.items.count > benchmark }
  end

  def merchants_items_prices(merchant_id)
    se.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(merchant_id)
    total = merchants_items_prices(merchant_id)
    (account_for_zero_items(total) / 100).round(2)
  end

  def all_merchants_averages
    se.merchants.all_merchants_ids.map { |merchant_id|
      average_item_price_for_merchant(merchant_id)}
  end

  def average_average_price_per_merchant
    total_averages = all_merchants_averages.reduce(:+)
    (total_averages / all_merchants_averages.count).round(2)
  end

  def average_prices_of_all_items
    se.items.average_prices_of_all_items
  end

  def average_items_price_standard_deviation_gi
    Math.sqrt(se.items.variance).round(2)
  end

  def two_standard_dev_above_mean_value_gi
     average_prices_of_all_items + (average_items_price_standard_deviation_gi * 2)
  end

  def golden_items
    benchmark = two_standard_dev_above_mean_value_gi
    se.items.all.find_all { |item| item.unit_price > benchmark }
  end

  def average_invoices_per_merchant
    (se.merchants.invoices_per_merchant.inject(0.0,:+) / number_of_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(variance_invoices).round(2)
  end

  def variance_invoices
    sum_deviations_from_the_mean_invoices / (number_of_merchants - 1)
  end

  def sum_deviations_from_the_mean_invoices
    se.merchants.invoices_per_merchant.inject(0) do |accum, invoices|
      accum + (invoices - average_invoices_per_merchant) ** 2
    end
  end

  def top_merchants_by_invoice_count
    benchmark = two_standard_dev_above_mean_invoices
    se.merchants.all.find_all { |merchant|
       merchant.invoices.count > benchmark}
  end

  def two_standard_dev_above_mean_invoices
    average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
  end

  def bottom_merchants_by_invoice_count
    benchmark = two_standard_dev_below_mean_invoices
    se.merchants.all.find_all { |merchant|
       merchant.invoices.count < benchmark }
  end

  def top_days_by_invoice_count
    hash_of_invoices_to_day_of_the_week
    return_weekday_hash_and_key_for_top_days.map do |days|
      days[0].to_s
    end
  end

  def return_weekday_hash_and_key_for_top_days
    benchmark = one_standard_dev_above_mean_value_top_days
    @wday_created.find_all { |wday_invoices|
      wday_invoices[1] > benchmark }
  end

  def average_invoices_per_day_standard_deviation
    Math.sqrt(variance_days)
  end

  def sum_deviations_from_the_mean_days
    invoices_per_day_of_the_week.inject(0) { |accum, invoices|
      accum + ((invoices - average_invoices_per_day) ** 2.0) }.to_f
  end

  def number_of_invoices
    se.invoices.all.count
  end

  def percentage_of_invoices_shipped_vs_pending_vs_returned
    pending = invoice_status(:pending)
    shipped = invoice_status(:shipped)
    returned = invoice_status(:returned)
    "Percentage of invoices shipped: #{shipped}% vs.
    pending #{pending}% vs. returned #{returned}%"
  end

  def invoice_status(status)
    (percentage_of_invoice_pending(status).count / number_of_invoices.to_f * 100.0).round(2)
  end

  def percentage_of_invoice_pending(status)
    se.invoices.all.find_all do |invoice|
      invoice.status == status
    end
  end

  def total_revenue_by_date(date)
    find_all_created_on_date(date).reduce(0.0) do |sum, invoice|
      if invoice.total == nil
        sum + 0
      else
       sum + invoice.total
      end
    end
  end

  def find_all_created_on_date(date)
    date = date.strftime("%Y-%m-%d")
    se.invoices.all.find_all do |invoice|
      invoice.created_at.to_s.include?(date)
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices      = se.invoices.find_all_by_merchant_id(merchant_id)
    paid_invoices = invoices.find_all { |invoice| invoice.is_paid_in_full? }
    invoice_items  = paid_invoices.flat_map do |invoice|
      se.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    item_quantity = Hash.new(0)
    invoice_item_quantity = invoice_items.each do |invoice_item|
      item_quantity[invoice_item.item_id] += invoice_item.quantity
    end
    max_item = item_quantity.max_by { |k, v| v}
    ties = item_quantity.find_all do |key, value|
      value == max_item[1]
    end.map{|pair| pair[0]}

    ties.map do |item_id|
      se.items.find_by_id(item_id)
    end
  end

end
