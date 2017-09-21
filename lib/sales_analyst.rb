require_relative 'sales_engine'
require_relative 'standard_deviation'
require_relative 'advanced_analytics'
require 'bigdecimal'

class SalesAnalyst
  include StandardDeviation
  include AdvancedAnalytics
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    average = se.total_items / se.total_merchants.to_f
    average.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation

    se.merchants.merchants.select do |merchant|
      merchant.items.count >= std_dev * 2
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)

    total_item_price = merchant.items.reduce(0) do |total_price, item|
      total_price + item.unit_price
    end
    if not total_item_price == 0
      return (total_item_price / merchant.items.count).round(2)
    else
      return 0
    end
  end

  def average_average_price_per_merchant
    price_averages = se.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average_average = price_averages.sum / price_averages.count
    average_average.round(2)
  end

  def golden_items
    std_dev = item_standard_deviation
    se.items.items.select do |item|
      item.unit_price >  std_dev * 2
    end
  end

  def average_invoices_per_merchant
    average = se.total_invoices / se.total_merchants.to_f
    average.round(2)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    se.merchants.merchants.select do |merchant|
      merchant.invoices.count > (average + std_dev * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    se.merchants.merchants.select do |merchant|
      merchant.invoices.count < (average - std_dev * 2)
    end
  end

  def top_days_by_invoice_count
    average = average_invoices_per_day
    invoice_count_by_day = se.number_of_invoices_by_day
    std_dev = daily_invoice_standard_deviation.ceil

    top_days = invoice_count_by_day.select do |day, number|
      invoice_count_by_day[day] > (average + std_dev)
    end
    top_days.keys
  end

  def average_invoices_per_day
    se.total_invoices.to_f / 7
  end

  def invoice_status(status)
    count = 0
    se.invoices.invoices.each {|invoice| count += 1 if invoice.status == status}
    percentage = count / se.total_invoices.to_f * 100
    percentage.round(2)
  end

  def total_revenue_by_date(date)
    count = 0.00
    se.invoices.invoices.each do |invoice|
      invoice_date = invoice.created_at.strftime('%Y-%m-%d')
      if invoice_date == date.strftime('%Y-%m-%d')
        invoice.invoice_items.each do |invoice_item|
          count += invoice_item.unit_price * invoice_item.quantity
        end
      end
    end
    count
  end

end
