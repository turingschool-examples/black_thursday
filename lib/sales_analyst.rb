require 'pry'

class SalesAnalyst
  attr_reader :ir,
              :mr
  def initialize(merchant_repository, item_repository, invoice_repository)
      @mr = merchant_repository
      @ir = item_repository
      @inv_repo = invoice_repository
  end

  def average_items_per_merchant
    sum = summed(@ir.items_array)
    (sum.to_f/@mr.all.count).round(2)
  end

  def summed(array)
    array.reduce(0) do |sum, item|
      sum + 1
    end
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_items = items_per_merchant
    individual_dev = items_per_merchant_deviation(merchant_items, average)
    each_squared = squared(individual_dev)
    standard_deviation(each_squared)
  end

  def items_per_merchant
    @ir.items_array.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant_deviation(items_per_merchant, average)
    items_per_merchant.map do | id, items |
      items.count - average
    end
  end

  def squared(deviation_array)
    deviation_array.map do | deviation |
      deviation ** 2
    end
  end

  def standard_deviation(squared)
    squaresum = squared.reduce(0) do |sum, square|
      sum + square
    end
    (Math.sqrt(squaresum/(squared.length - 1))).round(2)
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    merchants_hash = items_per_merchant.select do |id, items|
      (items.count - average) >= 3.26
    end
    @mr.merchants_array.find_all do |merchant|
      merchants_hash.include?(merchant.id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items_list = @ir.find_all_by_merchant_id(merchant_id)
    prices = items_list.map { |item| item.unit_price }
    sum_of_item_prices = summed_prices(prices)
    (sum_of_item_prices/prices.count).round(2)
  end

  def summed_prices(array)
    array.reduce(0) do |sum, item|
      sum + item
    end
  end

  def average_average_price_per_merchant
    merchant_id_array = @mr.merchants_array.map { |merchant| merchant.id }
    average_price_list = merchant_id_array.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    price_sum = summed_prices(average_price_list)
    (price_sum/average_price_list.count).round(2)
  end

  def golden_items
    average_price = average_average_price_per_merchant
    array_of_prices_subtracted = price_minus_average_price(average_price)
    prices_stnd_dev = price_standard_deviation(array_of_prices_subtracted)
    expensive_items(prices_stnd_dev)
  end

  def price_standard_deviation(prices_subtracted)
    squared_prices_subtracted = squared(prices_subtracted)
    standard_deviation(squared_prices_subtracted)
  end

  def price_minus_average_price(average_price)
    prices = @ir.items_array.map { |item| item.unit_price}
    prices_subtracted = prices.map do |price|
      (price - average_price)
    end
  end

  def expensive_items(stnd_dev)
    @ir.items_array.find_all { |item| item.unit_price >= 5805.38 }
  end

  def average_invoices_per_merchant
    all_invoices = @inv_repo.all.count
    all_merchants = @mr.all.count
    (all_invoices.to_f/all_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average_inv = average_invoices_per_merchant
    invoices_subtracted = merchant_invoices_minus_average_invoices(average_inv)
    squared_subtracted_invoices = squared(invoices_subtracted)
    standard_deviation(squared_subtracted_invoices)
  end

  def merchant_invoices_minus_average_invoices(average_invoices)
    merchant_ids_and_count = count_duplicates
    merchant_ids_and_count.values.map do |dup_count|
      (dup_count - average_invoices)
    end
  end

  def number_of_invoice_per_merchant
    @inv_repo.invoices_array.map do |invoice|
      invoice.merchant_id
    end
  end

  def count_duplicates
    merchant_invoice_count = {}
    merchant_id_array = number_of_invoice_per_merchant
    @mr.all.each do |merchant|
      number = merchant_id_array.count(merchant.id)
      merchant_invoice_count[merchant] = number
    end
    merchant_invoice_count
  end
end
