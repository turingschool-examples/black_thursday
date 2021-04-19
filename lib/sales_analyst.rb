require_relative 'compute'
require 'date'

class SalesAnalyst

  attr_reader :engine, :merchants, :items, :invoices

  def initialize(engine)
    @engine = engine
    @merchants = engine.merchants.array_of_objects
    @items = engine.items.array_of_objects
    @invoices = engine.invoices.array_of_objects
  end

  def get_merchant_ids(merchants)
    merchants.map do |merchant|
      merchant.id
    end
  end

  def find_all_items_by_merchant_id(merchant_id)
    items.find_all do |item_object|
      item_object.merchant_id == merchant_id
    end
  end

  def items_per_merchant
    merchants.map do |merchant|
      find_all_items_by_merchant_id(merchant.id).length
    end
  end

  def average_items_per_merchant
    Compute.mean(items_per_merchant.sum, items_per_merchant.length)
  end

  def average_items_per_merchant_standard_deviation
    adder_counter = items_per_merchant.sum do |number|
      (number - average_items_per_merchant)**2
    end
    Math.sqrt(adder_counter / (items_per_merchant.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    greater_than_1sd = mean + average_items_per_merchant_standard_deviation
    merchants.find_all do |merchant|
      find_all_items_by_merchant_id(merchant.id).length > greater_than_1sd
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = find_all_items_by_merchant_id(merchant_id)
    sum_of_prices = merchant_items.sum do |item_object|
      item_object.unit_price
    end
    if merchant_items.length != 0
      Compute.mean(sum_of_prices, merchant_items.length)
    else
      0
    end
  end

  def average_average_price_per_merchant
    items_sum = merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    Compute.mean(items_sum, merchants.length)
  end

  def total_item_price
    items.sum do |item_object|
      item_object.unit_price
    end
  end

  def average_price_per_item_standard_deviation
    mean = Compute.mean(total_item_price, items.length)
    adder_counter = items.sum do |item_object|
      (item_object.unit_price - mean)**2
    end
    Math.sqrt(adder_counter / (items.length - 1)).round(2)
  end

  def golden_items
    mean = Compute.mean(total_item_price, items.length)
    two_sd = average_price_per_item_standard_deviation * 2
    greater_than_2sd = mean + two_sd
    items.find_all do |item_object|
      item_object.unit_price >= greater_than_2sd
    end
  end

  ##### INVOICE ITERATION 2 ######

  def average_invoices_per_merchant
    Compute.mean(invoices_per_merchant.sum, invoices_per_merchant.length)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def invoices_per_merchant
    merchants.map do |merchant|
      find_all_invoices_by_merchant_id(merchant.id).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    adder_counter = invoices_per_merchant.sum do |number_of_invoices|
      (number_of_invoices - average_invoices_per_merchant)**2
    end
    Math.sqrt(adder_counter.to_f / (invoices_per_merchant.length - 1)).round(2)
  end

  def average_invoices_per_day_standard_deviation
    average_invoices_per_day = Compute.mean(invoices.length, 7)
    adder_counter = invoices_per_day.values.sum do |number_of_invoices|
      (number_of_invoices - average_invoices_per_day)**2
    end
    Math.sqrt(adder_counter.to_f / 6).round(2)
  end

  def invoices_per_day
    days = invoices.map do |invoice_object|
      invoice_object.created_at.strftime('%A')
    end
    sorted_days = days.group_by do |day|
      day
    end
    sorted_days.transform_values do |value|
      value.length
    end
  end

  def top_days_by_invoice_count
    days_hash = invoices_per_day.select do |key, value|
      value > average_invoices_per_day_standard_deviation + (invoices.length/7)
    end
    days_hash.keys
  end

  def invoice_status(status_symbol)
    sorted_invoices = []
     @invoices.each do |invoice|
       if invoice.status == status_symbol
      sorted_invoices.push(invoice)
      end
    end
    (sorted_invoices.length/@invoices.length.to_f*100).round(2)
  end

###THIS IS FOR THE NEXT PART OF ITERATION 2###
  # def merchants_with_high_item_count
  #   mean = average_items_per_merchant
  #   greater_than_1sd = mean + average_items_per_merchant_standard_deviation
  #   @merchants.find_all do |merchant|
  #     find_all_items_by_merchant_id(merchant.id).length > greater_than_1sd
  #   end
  # end
end
