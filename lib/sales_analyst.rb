require_relative 'merchant_repository'
require_relative 'item'
require_relative 'sales_engine'
require 'bigdecimal'
require 'time'
require 'pry'
class SalesAnalyst

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    BigDecimal.new(@parent.items.all.length.to_f / @parent.merchants.all.length.to_f, 3).to_f
  end

  def group_items_by_merchant
    @parent.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    sum_of_squared_differences = group_items_by_merchant.inject(0) do |sum, merchant|
      difference = merchant[1].length - average_items
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@parent.merchants.all.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 3).to_f
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    high_item_count = average_items + standard_deviation
    group_items_by_merchant.map do |merchant|
      if merchant[1].length > high_item_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end

  def average_item_price_for_merchant(id)
    items_by_merchant = group_items_by_merchant
    sum_of_item_prices = group_items_by_merchant[id].inject(0) do |sum, item|
      sum += item.unit_price
      sum
    end
    average_long = sum_of_item_prices / items_by_merchant[id].length
    return BigDecimal.new(average_long).round(2)
  end

  def average_average_price_per_merchant
    sum_of_averages = group_items_by_merchant.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant[0])
    end
    average_average_price = sum_of_averages / @parent.merchants.all.length
    return BigDecimal.new(average_average_price).round(2)
  end

  def item_price_standard_deviation(average_item_price)
    sum_of_squared_differences = @parent.items.all.inject(0) do |sum, item|
      difference = item.unit_price - average_item_price
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@parent.items.all.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 4)
  end

  def golden_items
    average_item_price = average_average_price_per_merchant
    standard_deviation = item_price_standard_deviation(average_item_price)
    golden_price = standard_deviation * 2 + average_item_price
    @parent.items.all.find_all do |item|
      item.unit_price > golden_price
    end
  end

  def average_invoices_per_merchant
    BigDecimal.new(@parent.invoices.all.length.to_f / @parent.merchants.all.length.to_f, 4).to_f
  end

  def group_invoices_by_merchant
    @parent.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def average_invoices_per_merchant_standard_deviation
    average_invoices = average_invoices_per_merchant
    sum_of_squared_differences = group_invoices_by_merchant.inject(0) do |sum, merchant|
      difference = merchant[1].length - average_invoices
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@parent.merchants.all.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 3).to_f
  end

  def top_merchants_by_invoice_count
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    high_invoice_count = average_invoices + standard_deviation * 2
    group_invoices_by_merchant.map do |merchant|
      if merchant[1].length > high_invoice_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end

  def bottom_merchants_by_invoice_count
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    low_invoice_count = average_invoices - standard_deviation * 2
    group_invoices_by_merchant.map do |merchant|
      if merchant[1].length < low_invoice_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end

  def group_by_day
    @parent.invoices.all.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def average_invoices_per_day
    @parent.invoices.all.length / 7
  end

  def invoice_per_day_standard_deviation
    average_invoices = average_invoices_per_day
    invoices_by_day = group_by_day
    sum_of_squared_differences = invoices_by_day.inject(0) do |sum, day|
      difference = day[1].length - average_invoices
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / 6
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 3).to_f
  end

  def top_days_by_invoice_count
    average_invoices = average_invoices_per_day
    invoice_standard_deviation = invoice_per_day_standard_deviation
    top_invoice_count = average_invoices + invoice_standard_deviation
    invoices_by_day = group_by_day
    invoices_by_day.map do |day|
      if day[1].length > top_invoice_count
        day[0]
      end
    end.compact
  end

  def invoice_status(status)
    matching_invoices = @parent.invoices.find_all_by_status(status)
    ((matching_invoices.length.to_f / @parent.invoices.all.length.to_f) * 100).round(2)
  end

  def group_transactions_by_invoice_id
    @parent.transactions.all.group_by do |transaction|
      transaction.invoice_id
    end
  end

  def invoice_paid_in_full?(invoice_id)
    transaction_by_invoice = group_transactions_by_invoice_id
    if transaction_by_invoice[invoice_id].nil?
      return false
    end
    transaction_by_invoice[invoice_id].any? do |transaction|
      transaction.result == :success
    end
  end

  def group_invoice_items_by_invoice_id
    @parent.invoice_items.invoice_items.group_by do |invoice_item|
      invoice_item.invoice_id
    end
  end

  def invoice_total(invoice_id)
    invoice_items_by_invoice = group_invoice_items_by_invoice_id
    invoice_items_by_invoice[invoice_id].inject(0) do |total, invoice_item|
      total += invoice_item.quantity * invoice_item.unit_price_to_dollars
      total.to_d
    end
  end

  def group_invoice_by_date
    @parent.invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%F")
    end
  end

  def group_invoice_items_by_invoice
    @parent.invoice_items.all.group_by do |invoice_item|
      invoice_item.invoice_id
    end
  end

  def calculates_revenue_per_invoice(invoice_id)
    invoice_items_by_invoice = group_invoice_items_by_invoice
    invoice_items_by_invoice[invoice_id].inject(0) do |revenue, invoice_item|
      revenue += invoice_item.unit_price * invoice_item.quantity
      revenue
    end
  end

  def total_revenue_by_date(date)
    date_formatted = date.strftime("%F")
    invoices_by_date = group_invoice_by_date
    invoices_by_date[date_formatted].inject(0) do |total_revenue, invoice|
      total_revenue += calculates_revenue_per_invoice(invoice.id)
      total_revenue
    end
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue[0..x - 1]
  end

  def merchants_ranked_by_revenue
    merch_revenue = @parent.merchants.all.map do |merchant|
      { merchant => revenue_by_merchant(merchant.id)}
    end
    ranked_merchants = merch_revenue.sort_by do |merchant|
      merchant.values.pop
    end.reverse
    ranked_merchants.map do |merchant_hash|
      merchant_hash.keys
    end.flatten
  end

  def merchants_with_pending_invoices
    group_invoices_by_merchant.inject([]) do |pending_merchants, merchant|
      no_pending_invoices = merchant[1].all? do |invoice|
        invoice_paid_in_full?(invoice.id)
      end
      if no_pending_invoices
        pending_merchants
      else
        pending_merchants << @parent.merchants.find_by_id(merchant[0])
      end
    end
  end

  def merchants_with_only_one_item
    items_by_merchant = group_items_by_merchant
    merchants_with_one_item = items_by_merchant.find_all do |merchant|
      merchant[1].length == 1
    end
    merchant_ids = merchants_with_one_item.map do |merchant|
      merchant[0]
    end
    merchant_ids.map do |merchant_id|
      @parent.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      Time.parse(merchant.created_at).strftime('%B').downcase == month.downcase
    end
  end

  def group_invoice_items_by_items
    @parent.invoice_items.all.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def calculates_revenue_per_item(item_id)
    invoice_items_by_item = group_invoice_items_by_items
    invoice_items_by_item[item_id].inject(0) do |revenue, invoice_item|
      if invoice_paid_in_full?(invoice_item.invoice_id)
        revenue += invoice_item.quantity * invoice_item.unit_price
        revenue
      else
        revenue += 0
        revenue
      end
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices_by_merchant = group_invoices_by_merchant
    invoices_by_merchant[merchant_id].inject(0) do |revenue, invoice|
      if invoice_paid_in_full?(invoice.id)
        revenue += invoice_total(invoice.id)
        revenue
      else
        revenue
      end
    end
  end

  def find_quantity_of_items_sold
    invoice_items_by_item = group_invoice_items_by_items
    x = invoice_items_by_item.inject(Hash.new(0)) do |items_by_quantity, item|
      items_by_quantity[item[0]] += find_quantity_per_item(item)
      items_by_quantity
    end
  end

  def find_quantity_per_item(item)
    item[1].inject(0) do |quantity, invoice_item|
      if invoice_paid_in_full?(invoice_item.invoice_id)
        quantity += invoice_item.quantity
        quantity
      else
        quantity
      end
    end
  end

  def find_quantities_by_merchant(merchant_id)
    find_quantity_of_items_sold.find_all do |item|
      @parent.items.find_by_id(item[0]).merchant_id == merchant_id
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    quantities = find_quantities_by_merchant(merchant_id)
    max_quantity = quantities.max_by do |item|
      item[1]
    end.last
    best_sellers = quantities.find_all do |item|
      item[1] == max_quantity
    end
    x = best_sellers.map do |item|
      @parent.items.find_by_id(item[0])
    end
  end

  def find_revenue_per_item(item)
    item[1].inject(0) do |revenue, invoice_item|
      if invoice_paid_in_full?(invoice_item.invoice_id)
        revenue += invoice_item.quantity * invoice_item.unit_price
        revenue
      else
        revenue
      end
    end
  end

  def find_revenue_of_all_items
    invoice_items_by_item = group_invoice_items_by_items
    invoice_items_by_item.inject(Hash.new(0)) do |items_by_revenue, item|
      items_by_revenue[item[0]] += find_revenue_per_item(item)
      items_by_revenue
    end
  end

  def find_item_revenue_by_merchant(merchant_id)
    find_revenue_of_all_items.find_all do |item|
      @parent.items.find_by_id(item[0]).merchant_id == merchant_id
    end
  end

  def best_item_for_merchant(merchant_id)
    revenues_per_item = find_item_revenue_by_merchant(merchant_id)
    max_revenue = revenues_per_item.max_by do |item|
      item[1]
    end
    @parent.items.find_by_id(max_revenue[0])
  end
end
