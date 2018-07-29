require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'standard_deviation'

class SalesAnalyst
  include StandardDeviation
  
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def group_items_by_merchant
    @se.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant
    group_items_by_merchant.values.map(&:count)
  end

  def average_items_per_merchant
    total_items = items_per_merchant.inject(0) do |sum, item_count|
      sum + item_count
    end
    ((total_items).round(2) / items_per_merchant.length.round(2)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    length_less_one = items_per_merchant.length - 1
    diffed_and_squared = []
    items_per_merchant.each do |count|
      diffed_and_squared  << (count - mean)**2
    end
    sum = diffed_and_squared.inject(0) do |sum, number|
      number + sum
    end
    divided = sum / length_less_one
    return (divided ** (1.0/2)).round(2)
  end

  def select_merchant_ids_over_standard_deviation
  mean = average_items_per_merchant
  grouped = group_items_by_merchant
  selected_ids = []
  grouped.each do |key, value|
    if value.length > average_items_per_merchant_standard_deviation + mean
      selected_ids << key
      end
    end
    return selected_ids
  end

  def merchants_with_high_item_count
    merchants = []
    selected_ids = select_merchant_ids_over_standard_deviation
    @se.merchants.all.each do |merchant|
      if selected_ids.include?(merchant.id)
        merchants << merchant
      end
    end
    return merchants
  end

  def average_item_price_for_merchant(merchant_id_number)
    grouped = group_items_by_merchant
    items = grouped[merchant_id_number]
    prices = []
    items.each do |item|
      prices << item.unit_price_to_dollars
    end
    total = prices.inject(0.00) do |sum, price|
      sum + price
    end
    (total / prices.length).round(2).to_d
  end

  def average_average_price_per_merchant
    grouped = group_items_by_merchant
    ids = grouped.keys
    average_prices = ids.map do |id|
      average_item_price_for_merchant(id)
    end
    sum = average_prices.inject(0.00) do |sum, price|
      sum + price
    end
    return (sum / average_prices.length).round(2).to_d
  end

  def average_item_price
    prices = []
    @se.items.all.each do |item|
      prices << item.unit_price_to_dollars
    end
    total_prices = prices.inject(0) do |sum, price|
      sum + price
    end
    (total_prices / (prices.length)).round(2)
  end

  def average_price_standard_deviation
    mean = average_item_price
    prices = @se.items.all.map do |item|
      item.unit_price_to_dollars
    end
    length_less_one = prices.length - 1
    diffed_and_squared = []
    prices.each do |price|
      diffed_and_squared << ((price - mean) ** 2).round(2)
    end
    total_diffed_and_squared = diffed_and_squared.inject(0) do |sum, price|
      sum + price
    end
    divided = (total_diffed_and_squared / length_less_one)
    return (divided ** (1/2.00)).round(2).to_d
  end

  def golden_items
    mean = average_item_price
    golden_items = []
    @se.items.all.each do |item|
      if item.unit_price_to_dollars > mean + (average_price_standard_deviation * 2)
        golden_items << item
      end
    end
    return golden_items
  end


#----------------Iteration Two---------------------------------
  def average_invoices_per_merchant
    (@se.invoices.all.count / @se.merchants.all.count.to_f).round(2)
  end

  # returns a hash with the merchant_id as key and array of invoice objects
  # that belong to that merchant
  def group_invoices_by_merchant
    @se.invoices.all.group_by(&:merchant_id)
  end

  # returns a hash with merchant_id as key and sum of invoice objects as value
  # invoices per merchant or ipm
  def invoices_per_merchant
    ipm = group_invoices_by_merchant
    ipm.inject(ipm) do |hash, (merchant_id, invoices)|
      hash[merchant_id] = invoices.count
      hash
    end
  end

# *sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant.values)
  end
# *sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
# *sales_analyst.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
# *sales_analyst.top_days_by_invoice_count # => ["Sunday", "Saturday"]
# *sales_analyst.invoice_status(:pending) # => 29.55
# sales_analyst.invoice_status(:shipped) # => 56.95
# sales_analyst.invoice_status(:returned) # => 13.5
end
