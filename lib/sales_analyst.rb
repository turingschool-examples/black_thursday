require 'pry'


class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def initialize(items, merchants, invoices = [], invoice_items = [], customers = [], transactions = [])
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
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
    merchant_id_array.map do |merchant|
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

  def top_merchants_by_invoice_count
    standard_deviation = average_invoices_per_merchant_standard_deviation
    merchant_ids = invoices_by_merchant.select do |merchant_id, invoices|
      (invoices.count - average_invoices_per_merchant) >= (standard_deviation * 2)
    end
    @merchants.all.select {|merchant| merchant_ids.include?(merchant.id)}
  end

  def bottom_merchants_by_invoice_count
    standard_deviation = average_invoices_per_merchant_standard_deviation
    merchant_ids = invoices_by_merchant.select do |merchant_id, invoices|
      (invoices.count - average_invoices_per_merchant) < (-standard_deviation * 2)
    end
    @merchants.all.select {|merchant| merchant_ids.include?(merchant.id)}
  end

  def invoices_by_day
    @invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def average_invoices_per_day
    (invoices_by_day.values.flatten.count.to_f/invoices_by_day.count).round(2)
  end

  def average_invoices_per_day_standard_deviation
    values_array = invoices_by_day.values.map {|invoices| invoices.count}
    standard_deviation(values_array, average_invoices_per_day)
  end

  def top_days_by_invoice_count
    standard_deviation = average_invoices_per_day_standard_deviation
    invoices_by_day.select do |day, invoices|
      (invoices.count - average_invoices_per_day) >= (standard_deviation)
    end.keys
  end

  def invoice_status(status_arg)
    i_c = @invoices.all.select do |invoice|
      invoice.status == status_arg
    end
    ((i_c.count.to_f / @invoices.all.count )*100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
      selected_transactions =@transactions.find_all_by_invoice_id(invoice_id)
    return false if selected_transactions == []
    if selected_transactions.any? {|transaction| transaction.result == :success}
      true
    else
      false
    end
  end
end
