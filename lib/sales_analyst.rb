require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/sales_analyst_deviation_helper'
require 'pry'

class SalesAnalyst
  include BlackThursdayHelper
  include SalesAnalystHelper

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_merchants = @sales_engine.merchants.all.count
    total_items = @sales_engine.items.all.count
    BigDecimal((total_merchants.to_f/total_items),3)
  end

  def average_items_per_merchant_standard_deviation
    mean = mean_method
    items_per_merchant = all_merchants.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).size
    end
    standard_dev(items_per_merchant, mean)
  end

  def merchants_with_high_item_count
    goal = average_items_per_merchant + average_items_per_merchant_standard_deviation

    all_merchants.find_all do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).size > goal
    end
  end

  def average_item_price_per_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    item_sum = items.inject(0) do |sum, item|
      sum + item.unit_price
    end
    average_price = item_sum/(items.count)
    BigDecimal(average_price, 4).round(2)
  end

  def average_average_price_per_merchant
    merchant_item_averages = all_merchants.map do |merchant|
      average_item_price_per_merchant(merchant.id)
    end
    averages_summed = merchant_item_averages.inject(0) do |sum, average|
      sum + average
    end
    averages_total = (averages_summed/ merchant_item_averages.size).round(2)
    BigDecimal(averages_total, 4)
  end

  def average_invoices_per_merchant
    total_merchants = @sales_engine.merchants.all.count
    total_invoices = @sales_engine.invoices.all.count
    BigDecimal((total_merchants.to_f/total_invoices),3)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = mean_method_for_invoices
    invoices_per_merchant = all_merchants.map do |merchant|
      @sales_engine.invoices.find_all_by_merchant_id(merchant.id).size
    end
    standard_dev(invoices_per_merchant, mean)
  end

  def top_merchants_by_invoice_count
    mean = mean_method_for_invoices
    doubled_standard_deviation = average_invoices_per_merchant_standard_deviation * 2
    all_invoices.find_all do |invoice|
    # binding.pry
      #ok so this goes into the invoices and find all the ones for particular merchant
      #then it will count it. if thats more than the standard deviation for the other merchants,
      #its "golden"-aka that one merchant has way more invoices to their name
      @sales_engine.invoices.find_all_by_merchant_id(invoice.merchant_id).size > (doubled_standard_deviation + mean)
    end
  end

  def bottom_merchants_by_invoice_count
      mean = mean_method_for_invoices
      doubled_standard_deviation = average_invoices_per_merchant_standard_deviation * 2
      all_invoices.find_all do |invoice|
        @sales_engine.invoices.find_all_by_merchant_id(invoice.merchant_id).size < (doubled_standard_deviation - mean)
      end
  end

  def top_days_by_invoice_count
    mean = all_invoices.size.to_f / count_invoices_per_day.size
    goal = mean + standard_dev(count_invoices_per_day, mean)

    top_days = invoices_by_day.find_all do |day, object_array|
      object_array.size > goal
    end
    remove_keys(top_days, Invoice)
  end

  def count_invoices_per_day
    invoices_by_day.map do |day, invoice|
      invoice.count
    end
  end

  def invoices_by_day
    all_invoices.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def remove_keys(data, type)
    data.flatten.delete_if do |element|
      element.is_a?(type)
    end
  end

  def invoice_status(status)
    invoices_by_status = all_invoices.count do |invoice|
      invoice.status == status.to_s
    end
    ((invoices_by_status.to_f / all_invoices.size) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    total = invoice_items.inject(0) do |sum, in_item|
      sum + in_item.quantity * in_item.unit_price_to_dollars
    end

    BigDecimal(total, total.to_s.size - 1)
  end

  def golden_items
    mean = all_prices_sum / all_items.size
    std = standard_dev(all_prices, mean)
    golden_goal = mean + std * 2

    all_items.find_all do |item|
      item.unit_price > golden_goal
    end
  end
end
