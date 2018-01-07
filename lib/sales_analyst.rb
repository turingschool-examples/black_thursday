require 'bigdecimal'
require 'pry'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :se,
              :average_item_prices

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (se.grab_all_items.count / se.grab_all_merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant
    (se.grab_all_invoices.count / se.grab_all_merchants.count.to_f).round(2)
  end

  def number_of_items_per_merchant
    se.grab_array_of_merchant_items
  end

  def number_of_invoices_per_merchant
    se.grab_array_of_merchant_invoices
  end

  def average_items_per_merchant_standard_deviation
    mean     = average_items_per_merchant
    variance = number_of_items_per_merchant.reduce(0) do |var, items|
      var + (items - mean) ** 2
    end
    (Math.sqrt(variance/(se.grab_all_merchants.count - 1))).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    variance = number_of_invoices_per_merchant.reduce(0) do |var, invoice|
      var + (invoice) ** 2
    end
    (Math.sqrt(variance/(se.grab_all_invoices.count - 1))).round(2)
  end

  def item_prices_mean
    items       = se.grab_all_items
    item_prices = items.reduce(0) { |result, item| result += item.unit_price.to_i}
    (item_prices / items.count).round(2)
  end

  def invoice_mean
    array = se.grab_array_of_merchant_invoices
    array.inject(0) { |sum, x| sum += x } / array.size.to_f
  end

  def item_price_standard_deviation # NEEDS TEST
    items = se.grab_all_items
    price_variance = items.reduce(0) do |result, item|
      result += (item.unit_price.to_i - item_prices_mean) ** 2
    end
    (Math.sqrt(price_variance/(items.count - 1))).round(2)
  end

  def merchants_with_high_item_count
    count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    se.grab_all_merchants.find_all do |merchant|
      merchant if merchant.items.count > count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant           = se.find_merchant_by_id(merchant_id)
    items              = se.find_item_by_merchant_id(merchant_id)
    summed_item_prices = items.reduce(0) { |res, item| res += item.unit_price}
    (summed_item_prices / items.count).round(2)
  end

  def average_average_price_per_merchant
    merchants = se.grab_all_merchants
    price = merchants.map {|merch| average_item_price_for_merchant(merch.id)}.sum
    (price / merchants.count).round(2)
  end

  def top_merchants_by_invoice_count

  end

  def golden_items
    items = se.grab_all_items
    double_deviation = (item_price_standard_deviation * 2)
    items.find_all do |item|
      price = item.unit_price
      if price > double_deviation
        item
      end
    end
  end

  #Creating Business Intelligence methods for Invoices
  def average_invoices_per_merchant
    (se.grab_all_invoices.count / se.grab_all_merchants.count.to_f).round(2)
  end

  def number_of_invoices_per_merchant
    se.grab_array_of_merchant_invoices
  end

  def average_invoices_per_merchant_standard_deviation
    mean     = average_invoices_per_merchant
    variance = number_of_invoices_per_merchant.reduce(0) do |var, invoices|
      var + (invoices - mean) ** 2
    end
    (Math.sqrt(variance/(se.grab_all_invoices.count - 1))).round(2)
  end

  # def invoice_status(status)
  #   var ={}
  #   se.grab_all_invoices.map do |invoice|
  #     var[invoice.status] =
  # end



end
