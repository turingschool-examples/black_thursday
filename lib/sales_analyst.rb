require_relative 'sales_engine'
require_relative 'stats'

class SalesAnalyst
  include Stats
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (se.all_items.count.to_f / se.all_merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(num_items_per_merchant.values).round(2)
  end

  def merchants_with_high_item_count
    bar = one_standard_deviation_bar
    high_sell = []
    num_items_per_merchant.each do |k,v|
      high_sell << k if v > bar
    end
    high_sell
  end

  def average_item_price_for_merchant(id)
    average(merchant_items_prices(id))
  end

  def average_average_price_per_merchant
    avg = []
    merchant_id_item_group.each do |key,value|
      avg << value.map {|item| item.unit_price}.reduce(:+) / value.count
    end
    average(avg)
  end

  def golden_items
    gold = []
    se.all_items.map {|item| item_std_dev(gold, item)}
    gold
  end

  def average_invoices_per_merchant
    (se.all_invoices.count.to_f / se.all_merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(num_invoices_per_merchant.values).round(2)
  end

  def top_merchants_by_invoice_count
    top       = []
    num_invoices_per_merchant.each do |merchant, invoices|
      invoice_std_dev(top, merchant, invoices)
    end
    top
  end

  def bottom_merchants_by_invoice_count
    bottom = []
    num_invoices_per_merchant.each do |merchant, invoices|
      bad_merchants(bottom, merchant, invoices)
    end
    bottom
  end

  def top_days_by_invoice_count
    invoices_by_day_count
  end

end
