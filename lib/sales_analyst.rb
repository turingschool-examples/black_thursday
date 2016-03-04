require_relative '../lib/sales_engine'
require 'csv'
require 'pry'
require 'bigdecimal'

class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (@se.items.repository.count.to_f/@se.merchants.repository.count.to_f).round(2)
  end

  def items_per_merchant_hash #need test?
    @se.items.repository.group_by { |item| item.merchant_id }
  end

  def item_count_per_merchant_hash # need test?
    items_per_merchant_hash.map { |merchant_id, items| [merchant_id, items.count] }.to_h
  end

  def average_items_per_merchant_standard_deviation
    variance = item_count_per_merchant_hash.values.map do |value|
          (value - average_items_per_merchant)**2
        end.reduce(:+)/(@se.merchants.repository.count.to_f - 1)

    Math.sqrt(variance).round(2)
  end

  def one_std_dev_for_average_items_per_merchant
    average_items_per_merchant_standard_deviation + average_items_per_merchant
  end

  def merchants_with_high_item_count
    one_standard_deviaton = one_std_dev_for_average_items_per_merchant
    item_count_per_merchant_hash.find_all do |merchant_id, item_count|
      merchant_id if item_count > one_standard_deviaton
    end.map do |element|
          @se.merchants.find_by_id(element[0])
        end
  end

  def average_item_price_for_merchant(merchant_id)
    hash = items_per_merchant_hash
    price = BigDecimal.new(hash[merchant_id].reduce(0) do |sum, item|
      sum += item.unit_price
    end)/hash[merchant_id].count
    price.round(2)
  end

  def average_average_price_per_merchant
    hash = items_per_merchant_hash
    average = hash.map do |merchant, items|
      average_item_price_for_merchant(merchant)
    end.reduce(:+)/hash.count.to_f

    BigDecimal.new("#{average}").round(2)
  end

  def average_item_price_for_merchant_hash # need to test hash
    item_hash = items_per_merchant_hash
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
    items = @se.items.repository

    variance = items.map do |item|
      ((item.unit_price - average_price_of_all_items)**2)
    end.reduce(:+)/(items.count - 1)

    Math.sqrt(variance).round(2)
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

  def invoices_per_merchant_hash #need test?
    @se.invoices.repository.group_by { |invoice| invoice.merchant_id }
  end

  def invoice_count_per_merchant_hash # need test?
    @se.merchants.repository.map { |merchant| [merchant.id, merchant.invoices.count] }.to_h
    # invoices_per_merchant_hash.map { |merchant_id, invoices| [merchant_id, invoices.count] }.to_h
  end

  def average_invoices_per_merchant_standard_deviation
    variance = invoice_count_per_merchant_hash.values.map do |value|
          (value - average_invoices_per_merchant) ** 2
        end.reduce(:+)/(@se.merchants.repository.count.to_f - 1)

    Math.sqrt(variance).round(2)
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
    # average of invoice / day = total number of invoices / total number of days per week (7)
    number_of_week_days = 7
    @se.invoices.repository.count/number_of_week_days
  end

  def invoices_for_day_hash
    @se.invoices.repository.group_by { |invoice| invoice.created_at.strftime('%A')}
  end

  def count_of_invoices_for_day_hash
    invoices_for_day_hash.map { |week_day, invoices| [week_day, invoices.count] }.to_h
  end

  def average_invoices_per_day_standard_deviation
    variance = count_of_invoices_for_day_hash.values.map do |value|
          (value - average_invoices_per_day) ** 2
        end.reduce(:+)/(7.to_f - 1)

    Math.sqrt(variance).round(2)
  end


  def one_std_dev_above_average_invoice_count
    average_invoices_per_day_standard_deviation + average_invoices_per_day
  end

  def top_days_by_invoice_count
    # returns array of days of the week on which invoices are created at more than one std dev
    one_standard_deviation =  one_std_dev_above_average_invoice_count
    top_days = count_of_invoices_for_day_hash.find_all do |week_day, invoice_count|
      week_day if invoice_count > one_standard_deviation
    end.to_h
    top_days.keys
  end

  def invoice_status(status_symbol)
    @se.invoices.percent_by_status(status_symbol)
  end


end
