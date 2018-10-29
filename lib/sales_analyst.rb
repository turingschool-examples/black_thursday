require 'pry'


class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(items, merchants, invoices = [])
    @items = items
    @merchants = merchants
    @invoices = invoices
  end

  def items_by_merchant
    @items.all.group_by {|item| item.merchant_id}
  end

  def average(array)
    (sums(array).to_f/array.count).round(2)
  end

  def average_items_per_merchant
    (items_by_merchant.values.flatten.count.to_f/items_by_merchant.count).round(2)
  end

  def sums(array)
    array.reduce(:+)
  end

  def variance(values_array, mean)
    sums(values_array.map {|value|(value - mean)**2})
  end

  def standard_deviation(values_array, mean)
     Math.sqrt(variance(values_array, mean)/(values_array.count-1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    values_array = items_by_merchant.values.map {|items| items.count}
    standard_deviation(values_array, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    merchants_hash = items_by_merchant.select do |id, items|
      (items.count - average_items_per_merchant) > 3.26
    end
    @merchants.all.find_all {|merchant| merchants_hash.include?(merchant.id)}
  end

  def average_item_price_for_merchant(merchant_id)
    items_by_merchant_array = @items.find_all_by_merchant_id(merchant_id)
    item_prices_array = items_by_merchant_array.map {|item| item.unit_price}
    BigDecimal(average(item_prices_array),6)
  end

  def average_price_per_merchant
    merchant_id_array = @merchants.all.map { |merchant| merchant.id }
    array_of_averages = merchant_id_array.map do |merchant|
      average_item_price_for_merchant(merchant)
    end
  end

  def average_average_price_per_merchant
    BigDecimal(average(average_price_per_merchant),6)
  end

  def average_prices_per_merchant_standard_deviation
    prices = @items.all.map {|item| item.unit_price}
    standard_deviation(prices, average_average_price_per_merchant)
  end

  def golden_items
    standard_deviation = average_prices_per_merchant_standard_deviation
    @items.all.find_all { |item| item.unit_price >= standard_deviation * 2 }
  end

  def invoices_by_merchant
    @invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def average_invoices_per_merchant
    (invoices_by_merchant.values.flatten.count.to_f/invoices_by_merchant.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    value_array =
    invoices_by_merchant.values.map do |invoices|
      invoices.count
    end
    standard_deviation(value_array, average_invoices_per_merchant)
  end
end
