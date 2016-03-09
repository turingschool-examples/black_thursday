require_relative '../lib/sales_engine'
require 'csv'
require 'pry'
require 'bigdecimal'

class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.all.count.to_f/@se.merchants.all.count.to_f).round(2)
  end

  def find_squared_difference(elements, average)
    elements.values.map do |value|
      (value - average) ** 2
    end.reduce(:+).to_f
  end

  def find_sample(sample)
    sample.count.to_f - 1
  end

  def find_standard_deviation(elements, average, sample)
    variance = find_squared_difference(elements, average)/find_sample(sample)
    Math.sqrt(variance).round(2)
  end

  def average_items_per_merchant_standard_deviation
    find_standard_deviation(@se.merchants.item_count_per_merchant_hash, average_items_per_merchant, @se.merchants.all)
  end

  def one_std_dev_for_average_items_per_merchant
    average_items_per_merchant_standard_deviation + average_items_per_merchant
  end

  def merchants_with_high_item_count
    one_standard_deviaton = one_std_dev_for_average_items_per_merchant
    @se.merchants.item_count_per_merchant_hash.find_all do |merchant_id, item_count|
      merchant_id if item_count > one_standard_deviaton
    end.map do |element|
          @se.merchants.find_by_id(element[0])
        end
  end

  def average_item_price_for_merchant(merchant_id)
    hash = @se.merchants.items_per_merchant_hash
    price = BigDecimal.new(hash[merchant_id].reduce(0) do |sum, item|
      sum += item.unit_price
    end)/hash[merchant_id].count
    price.round(2)
  end

  def average_average_price_per_merchant
    hash = @se.merchants.items_per_merchant_hash
    average = hash.map do |merchant, items|
      average_item_price_for_merchant(merchant)
    end.reduce(:+)/hash.count.to_f

    BigDecimal.new("#{average}").round(2)
  end

  def average_item_price_for_merchant_hash # need to test hash
    item_hash = @se.merchants.items_per_merchant_hash
    result = Hash.new
    item_hash.each_key do |merchant_id|
      result[merchant_id] = average_item_price_for_merchant(merchant_id)
    end
    result
  end

  def average_price_of_all_items
    @se.items.repository.reduce(0) do |sum, item|
      sum += item.unit_price
    end/@se.items.repository.count
  end

  def average_item_price_standard_deviation
    find_standard_deviation(@se.items.item_unit_price_hash, average_price_of_all_items, @se.items.all)
  end

  def two_std_dev_for_average_item_price
    ((average_item_price_standard_deviation * 2) + average_price_of_all_items).to_f.round(2)
  end

  def golden_items
    two_standard_deviations = two_std_dev_for_average_item_price
    @se.items.repository.find_all do |item|
      item if item.unit_price > two_standard_deviations
    end
  end

  def average_invoices_per_merchant
    (@se.invoices.repository.count.to_f/@se.merchants.repository.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    find_standard_deviation(@se.merchants.invoice_count_per_merchant_hash, average_invoices_per_merchant, @se.merchants.all)
  end

  def two_std_dev_average_invoice_count
    average_invoices_per_merchant_standard_deviation * 2
  end

  def two_std_dev_above_average_invoice_count
    (average_invoices_per_merchant + two_std_dev_average_invoice_count).to_f.round(2)
  end

  def two_std_dev_below_average_invoice_count
    (average_invoices_per_merchant - two_std_dev_average_invoice_count).to_f.round(2)
  end

  def top_merchants_by_invoice_count
    two_standard_deviations = two_std_dev_above_average_invoice_count
    @se.merchants.repository.find_all do |merchant|
      merchant if merchant.invoices.count > two_standard_deviations
    end
  end

  def bottom_merchants_by_invoice_count
    two_standard_deviations = two_std_dev_below_average_invoice_count
    @se.merchants.repository.find_all do |merchant|
      merchant if merchant.invoices.count < two_standard_deviations
    end
  end

  def average_invoices_per_day
    number_of_week_days = 7
    @se.invoices.repository.count/number_of_week_days
  end

  def average_invoices_per_day_standard_deviation # need to refactor
    variance = @se.invoices.count_of_invoices_for_day_hash.values.map do |value|
          (value - average_invoices_per_day) ** 2
        end.reduce(:+)/(7.to_f - 1)
    Math.sqrt(variance).round(2)
  end

  def one_std_dev_above_average_invoice_count
    average_invoices_per_day_standard_deviation + average_invoices_per_day
  end

  def top_days_by_invoice_count
    one_standard_deviation =  one_std_dev_above_average_invoice_count
    top_days = @se.invoices.count_of_invoices_for_day_hash.find_all do |week_day, invoice_count|
      week_day if invoice_count > one_standard_deviation
    end.to_h
    top_days.keys
  end

  def invoice_status(status_symbol)
    @se.invoices.percent_by_status(status_symbol)
  end

  def total_revenue_by_date(date)
    @se.invoices.find_all_by_date(date).map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def top_revenue_earners(number_of_earners = 20)
    @se.merchants.get_top_earners_by_earned_revenue(number_of_earners)
  end

  def merchants_ranked_by_revenue
    @se.merchants.sort_all_by_earned_revenue.reverse
  end

  def merchants_with_pending_invoices
    @se.merchants.merchants_with_failed_transaction
  end

  def merchants_with_only_one_item
    @se.merchants.all.find_all { |merchant| merchant.items.count == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    @se.merchants.all.find_all do |merchant|
      merchant.created_at.strftime("%B") == month
    end.find_all do |merchant|
      merchant.items.count == 1
    end.uniq
  end

  def revenue_by_merchant(merchant_id)
    @se.merchants.find_by_id(merchant_id).all_revenue
  end

  def most_sold_item_for_merchant(merchant_id)
    invoice_items = @se.invoices.find_all_by_merchant_id(merchant_id).map do |invoice|
      invoice.is_paid_in_full? ? @se.invoice_items.find_all_by_invoice_id(invoice.id) : nil
    end.compact.flatten

    max_quantity = invoice_items.max_by do |invoice_item|
      invoice_item.quantity
    end.quantity

    invoice_items.map do |invoice_item|
      invoice_item.item if invoice_item.quantity == max_quantity
    end.compact
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = @se.invoices.find_all_by_merchant_id(merchant_id).map do |invoice|
      invoice.is_paid_in_full? ? @se.invoice_items.find_all_by_invoice_id(invoice.id) : nil
    end.compact.flatten

    items_and_invoice_items_hash = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end

    items_and_invoice_items_hash.map do |item_id, invoice_item|
      [@se.items.find_by_id(item_id), invoice_item.reduce(0) do |revenue, invoice_item|
        revenue += invoice_item.unit_price * invoice_item.quantity
      end]
    end.max_by do |revenue|
      revenue[1]
    end.first
  end

end
