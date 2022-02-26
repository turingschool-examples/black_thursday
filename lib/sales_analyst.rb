require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

require 'date'
require 'bigdecimal'
require 'pry'
require 'CSV'

class SalesAnalyst

  def initialize(merchants, items, invoices)
    @merchants = merchants
    @items = items
    @invoices = invoices
  end

  def average_items_per_merchant
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end
    ((merchant_items.values.sum).to_f / merchant_items.keys.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end

    average_merchant_items = ((merchant_items.values.sum).to_f / merchant_items.keys.count)
    empty = []
    merchant_items.values.each do |number|
      result = (number - average_merchant_items) * (number - average_merchant_items)
      empty << result
    end

    Math.sqrt(empty.sum / (merchant_items.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end

    average_merchant_items = ((merchant_items.values.sum).to_f / merchant_items.keys.count)
    item_count_standard = average_merchant_items + average_items_per_merchant_standard_deviation

    high_item_count_merchants_id = merchant_items.find_all do |key,value|
      key if value > item_count_standard
    end

    high_item_count_merchants_id.map do |merchants_id|
      @merchants.find_by_id(merchants_id[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @items.find_all_by_merchant_id(merchant_id)
    merchant_item_prices = merchant_items.map {|item| item.unit_price}
    (merchant_item_prices.sum / merchant_item_prices.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_ids = @merchants.merchants.map {|merchant| merchant.id}
    averages = merchant_ids.map { |id| average_item_price_for_merchant(id)}
    (averages.sum / averages.count).round(2)
  end

  def average_item_price
    item_prices = @items.items.map {|item| item.unit_price_to_dollars}
    item_prices.sum / item_prices.length
  end

  def item_price_std
    item_prices = @items.items.map {|item| item.unit_price_to_dollars}
    sq_item_prices = item_prices.map do|price|
      (price - average_item_price) ** 2
    end
    Math.sqrt(sq_item_prices.sum / (sq_item_prices.count - 1))
  end

  def golden_items
    golden_minimum = (average_item_price + (item_price_std * 2))
    @items.items.find_all do |item|
      item.unit_price_to_dollars > golden_minimum
    end
  end

  def average_invoices_per_merchant
    merchant_ids = @invoices.invoices.map {|invoice| invoice.merchant_id}
    merchant_invoices = Hash.new(0)
    merchant_ids.each do |id|
      merchant_invoices[id] += 1
    end
    ((merchant_invoices.values.sum).to_f / merchant_invoices.keys.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_ids = @invoices.invoices.map {|invoice| invoice.merchant_id}
    merchant_invoices = Hash.new(0)
    merchant_ids.each do |id|
      merchant_invoices[id] += 1
    end

    average_merchant_invoices= ((merchant_invoices.values.sum).to_f / merchant_invoices.keys.count)
    empty = []
    merchant_invoices.values.each do |number|
      result = (number - average_merchant_invoices) * (number - average_merchant_invoices)
      empty << result
    end

    Math.sqrt(empty.sum / (merchant_invoices.count - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    golden_invoices = (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))

    merchant_ids = @invoices.invoices.map {|invoice| invoice.merchant_id}
    merchant_invoices = Hash.new(0)
    merchant_ids.each do |id|
      merchant_invoices[@merchants.find_by_id(id)] += 1
    end

    golden_merchants = merchant_invoices.select do |merchant, invoice_count|
      invoice_count > golden_invoices
    end
    golden_merchants.keys
  end

  def bottom_merchants_by_invoice_count
    ungolden_invoices = (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))

    merchant_ids = @invoices.invoices.map {|invoice| invoice.merchant_id}
    merchant_invoices = Hash.new(0)
    merchant_ids.each do |id|
      merchant_invoices[@merchants.find_by_id(id)] += 1
    end

    ungolden_merchants = merchant_invoices.select do |merchant, invoice_count|
      invoice_count < ungolden_invoices
    end
    ungolden_merchants.keys
  end

  def invoices_by_day
    @invoices.invoices.map do |invoice|
       Time.parse(invoice.created_at).wday
    end
  end

  def invoices_per_day
    invoices_per_day_hash = Hash.new(0)
    invoices_by_day.each do |day|
      invoices_per_day_hash[day] += 1
    end
    invoices_per_day_hash
  end

  def average_invoices_per_day
    invoices_per_day.values.sum / 7
  end

  def invoices_per_day_STD
    square_difference_sum = invoices_per_day.values.map do |day_count|
      (day_count - average_invoices_per_day) ** 2
    end.sum
    Math.sqrt(square_difference_sum / (invoices_per_day.values.count - 1))
  end

  def num_to_day_converter(num)
    if num == 0
      'Sunday'
    elsif num == 1
      'Monday'
    elsif num == 2
      'Tuesday'
    elsif num == 3
      'Wednesday'
    elsif num == 4
      'Thursday'
    elsif num == 5
      'Friday'
    elsif num == 6
      'Saturday'
    end
  end

  def top_days_by_invoice_count
    golden_day_count = average_invoices_per_day + invoices_per_day_STD
    golden_days = invoices_per_day.select do |day_of_the_week, num_invoices|
      num_invoices > golden_day_count
    end
    golden_weekdays = golden_days.keys.map {|day| num_to_day_converter(day)}
  end


end
