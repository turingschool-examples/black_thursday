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

#----------------ITERATION TWO---------------------------------

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

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant.values)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    bar = two_standard_deviations_above(invoices_per_merchant.values)
    invoices_per_merchant.each do |merchant_id, invoice|
      if invoice > bar
        merchant = @se.merchants.find_by_id(merchant_id)
        top_merchants << merchant
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    bar = two_standard_deviations_below(invoices_per_merchant.values)
    invoices_per_merchant.each do |merchant_id, invoice|
      if invoice < bar
        merchant = @se.merchants.find_by_id(merchant_id)
        bottom_merchants << merchant
      end
    end
    bottom_merchants.compact
  end

  def day_of_the_week
    @se.invoices.all.map do |invoice|
      Date::DAYNAMES[invoice.created_at.wday]
    end
  end

  def group_by_day_of_the_week
    day_of_the_week.inject(Hash.new(0)) do |hash, day|
      hash[day] += 1
      hash
    end
  end

  def top_days_by_invoice_count
    top_days = []
    values = group_by_day_of_the_week.values
    bar = (average(values) + standard_deviation(values)).round
    group_by_day_of_the_week.each do |day, count|
      if count > bar
        top_days << day
      end
    end
    top_days
  end

  def invoice_status(status)
    invoices = @se.invoices.all.count
    by_status = @se.invoices.find_all_by_status(status).count
    ((by_status / invoices.to_f) * 100).round(2)
   end

#-------------------ITERATION THREE------------------------------------
  def find_invoice(invoice_id)
    selected = []
    @se.invoices.all.each do |invoice|
      if invoice.id == invoice_id
        selected << invoice
      end
    end
    return selected
  end

  def grab_all_transactions(invoice_id)
    invoice = find_invoice(invoice_id)
    result = []
    @se.transactions.all.each do |transaction|
      if transaction.invoice_id == invoice_id
        result << transaction
      end
    end
    return result
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = grab_all_transactions(invoice_id)
    statuses = []
    transactions.each do |transaction|
      statuses << transaction.result
    end
    if statuses.include?(:success)
      true
    else
      false
    end
  end

  def invoice_total(invoice_id)
   invoice_items = @se.invoice_items.find_all_by_invoice_id(invoice_id)
   total_price_per_pruchase = invoice_items.map do |invoice_item|
     invoice_item.quantity * invoice_item.unit_price
   end
   sum = total_price_per_pruchase.inject(0) do |total, cost|
     total + cost
   end
   BigDecimal(sum, 7)
 end



end

#----------------------ITERATION FOUR----------------------------------
#I will put iteration four methods here
