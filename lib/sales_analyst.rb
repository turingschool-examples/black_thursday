require_relative 'maths'
require 'bigdecimal'

class SalesAnalyst
  include Maths
  attr_reader :se

  def initialize(parent)
    @se = parent
  end

  def average_items_per_merchant
    (@se.items.all.count.to_f / @se.merchants.all.count).round(2)
  end

  def merchant_stock
    @se.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def total_inventory
    merchant_stock.map do |merchant, items|
      [items.count.to_d]
    end
  end

  def average_items_per_merchant_standard_deviation
     standard_deviation(total_inventory.flatten)
  end

  def merchants_with_high_item_count
   cutoff = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_count = @se.merchants.all.map do |merchant|
    if merchant_stock[merchant.id]
      if ((merchant_stock[merchant.id]).count - cutoff) >= 0
      merchant
      end
    end
  end
    high_count.compact
  end

  def prices
    @se.items.all.map { |item| item.unit_price }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @se.items.find_all_by_merchant_id(merchant_id)
    merchant_prices = merchant_items.map { |item| item.unit_price }
    mean(merchant_prices).round(2)
  end

  def average_price_per_merchant
    merchant_ids = @se.merchants.all.map { |merchant| merchant.id }
    merchant_ids.map { |id| average_item_price_for_merchant(id) }
  end

  def average_average_price_per_merchant
    mean(average_price_per_merchant).round(2)
  end

  def price_standard_deviation
     standard_deviation(prices)
  end

  def golden_items
    two_above = average_average_price_per_merchant + (price_standard_deviation * 2)
    @se.items.all.find_all { |item| item.unit_price > two_above }
  end

  def average_invoices_per_merchant
    total_merchants = @se.merchants.all.count
    total_invoices = @se.invoices.all.count
    BigDecimal((total_invoices.to_d / total_merchants), 3).round(2).to_f
  end

  def average_invoices_per_merchant
    total_merchants = @se.merchants.all.count
    total_invoices = @se.invoices.all.count
    BigDecimal((total_invoices.to_d / total_merchants), 3).round(2).to_f
  end

  def invoice_stock
    @se.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def average_invoices_per_merchant_standard_deviation
    totals = invoice_stock.map do |merchant, invoices|
      [invoices.count.to_d]
    end
     standard_deviation(totals.flatten)
  end

  def top_merchants_by_invoice_count
    cutoff = (average_invoices_per_merchant) + (average_invoices_per_merchant_standard_deviation * 2)
    high_count = @se.merchants.all.map do |merchant|
    if invoice_stock[merchant.id]
      if ((invoice_stock[merchant.id]).count - cutoff) >= 0
      merchant
      end
    end
  end
    high_count.compact
  end

  def bottom_merchants_by_invoice_count
    cutoff = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    lows = []
    @se.merchants.all.map do |merchant|
      all_invoices = @se.invoices.find_all_by_merchant_id(merchant.id)
      count = all_invoices.count
      if count <= cutoff
        lows << merchant
      end
    end
    lows
  end

  def days_array
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def average_invoices_per_day
    total_invoices = @se.invoices.all.count.to_f
    total_days = 7.0
    (total_invoices / total_days).round(2)
  end

  def average_invoices_per_day_standard_deviation
    array = average_days_occurrence
    average = average_invoices_per_day
    differences = differences_from_average(array, average)
    squares = square_each_amount(differences)
    sum = sum_amount(squares)
    result = sum / 6.0
    Math.sqrt(result).round(2)
  end

  def average_days_occurrence
    days_array.map do |day|
      occurrences = @se.invoices.find_all_by_day(day)
      occurrences.count
    end
  end

  def invoice_status(sym)
    percentage = @se.invoices.find_all_by_status(sym).count.to_f / @se.invoices.all.count
    percentage = percentage * 100
    percentage.round(2)
  end

  def average_days
    days = average_days_occurrence.inject(0) do |sum, num|
      sum += num
    end
      (days / 7.0).round(2)
  end

  def top_days_by_invoice_count
    high_level = average_invoices_per_day_standard_deviation + average_days
    golden = []
    average_days_occurrence.each_with_index do |day, index|
      if day >= high_level
        golden << [days_array[index]]
      end
    end
    golden.flatten
  end

  def invoice_paid_in_full?(invoice_id)
    invoices = @se.transactions.find_all_by_invoice_id(invoice_id)
    invoices.any? do |invoice|
      invoice.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @se.invoice_items.find_all_by_invoice_id(invoice_id)
    prices = invoice_items.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity.to_d
    end
    total_price = prices.inject do |sum, number|
      sum + number
    end
    total_price
  end

  def total_revenue_by_date(date)
    found_invoices = @se.invoices.find_all_by_date(date)
    total_revenue = 0.to_d
    found_invoices.each do |invoice|
      total_revenue += invoice_total(invoice.id)
    end
    total_revenue
  end

  def matched_invoices
    matched = {}
    @se.invoices.all.each do |invoice|
      matched[invoice.id] = invoice.merchant_id
    end
    matched
  end

  def pending_scrubbed
    matched_invoices.select do |key, value|
      invoice_paid_in_full?(key)
    end
  end

  def invoice_gather
    matched = {}
    pending_scrubbed.each do |invoice|
      newkey = invoice_total(invoice[0]).to_d
      matched[newkey] = invoice[1]
    end
    matched
  end

  def invoice_arrays_by_merchant
    good_invoices = invoice_gather
    good_merchants = good_invoices.values.uniq
    grouped = {}
    good_merchants.each do |merchant|
      total_calc = []
      good_invoices.each do |data|
        total_calc << data[0] if data[1] == merchant
      end
      grouped[merchant] = total_calc
    end
    grouped
  end

  def invoice_totals_by_merchant
    finally = {}
    invoice_arrays_by_merchant.each do |array|
      summed = 0.to_d
      array[1].each do |number|
        summed += number
      end
    finally[array[0]] = summed
    end
    finally
  end

  def top_revenue_earners(x = 20)
    best = invoice_totals_by_merchant.sort_by do |block|
      block[1]
    end.reverse
    limit = x - 1
    top = best[0..limit]
    top.map do |fuckthis|
      @se.merchants.find_by_id(fuckthis[0])
    end
  end

  def pending_invoices
    @se.invoices.all.map do |invoice|
      if !invoice_paid_in_full?(invoice.id)
       invoice
      end
    end.compact
  end

  def merchants_with_pending_invoices
    invoices  = pending_invoices
    merchants = invoices.map do |invoice|
        invoice = @se.merchants.find_by_id(invoice.merchant_id)
    end.uniq
      merchants
  end

  def merchants_with_only_one_item
    singles = []
    @se.merchants.all.each do |merchant|
      items = @se.items.find_all_by_merchant_id(merchant.id)
      if items.count == 1
          singles << merchant
      end
    end
    singles.uniq
  end

end
