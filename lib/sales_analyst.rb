require_relative 'merchant_repository'
require_relative 'item'
require_relative 'sales_engine'
require 'bigdecimal'
require 'time'
require 'pry'
class SalesAnalyst

  def initialize(parent)
    @parent = parent
    @merchants = parent.merchants.merchants
    @items = parent.items.items
    @items_by_merchant = group_items_by_merchant
    @invoices = parent.invoices.invoices
    @invoices_by_merchant = group_invoices_by_merchant
  end

  def average_items_per_merchant
    BigDecimal.new(@items.length.to_f / @merchants.length.to_f, 3).to_f
  end

  def group_items_by_merchant
    @items.group_by do |item|
      item.merchant_id
    end
  end

  def average_items_per_merchant_standard_deviation
    average_items = average_items_per_merchant
    sum_of_squared_differences = @items_by_merchant.inject(0) do |sum, merchant|
      difference = merchant[1].length - average_items
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@merchants.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 3).to_f
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    high_item_count = average_items + standard_deviation
    @items_by_merchant.map do |merchant|
      if merchant[1].length > high_item_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end

  def average_item_price_for_merchant(id)
    items_by_merchant = group_items_by_merchant
    sum_of_item_prices = @items_by_merchant[id].inject(0) do |sum, item|
      sum += item.unit_price
      sum
    end
    average_long = sum_of_item_prices / items_by_merchant[id].length
    return BigDecimal.new(average_long).round(2)
  end

  def average_average_price_per_merchant
    sum_of_averages = @items_by_merchant.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant[0])
    end
    average_average_price = sum_of_averages / @merchants.length
    return BigDecimal.new(average_average_price).round(2)
  end

  def item_price_standard_deviation(average_item_price)
    sum_of_squared_differences = @items.inject(0) do |sum, item|
      difference = item.unit_price - average_item_price
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@items.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 4)
  end

  def golden_items
    average_item_price = average_average_price_per_merchant
    standard_deviation = item_price_standard_deviation(average_item_price)
    golden_price = standard_deviation * 2 + average_item_price
    @items.find_all do |item|
      item.unit_price > golden_price
    end
  end

  def average_invoices_per_merchant
    BigDecimal.new(@invoices.length.to_f / @merchants.length.to_f, 4).to_f
  end

  def group_invoices_by_merchant
    @invoices.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def average_invoices_per_merchant_standard_deviation
    average_invoices = average_invoices_per_merchant
    sum_of_squared_differences = @invoices_by_merchant.inject(0) do |sum, merchant|
      difference = merchant[1].length - average_invoices
      sum += (difference ** 2)
      sum
    end
    quotient = sum_of_squared_differences / (@merchants.length - 1)
    standard_deviation_long = Math.sqrt(quotient)
    return BigDecimal.new(standard_deviation_long, 3).to_f
  end


  def top_merchants_by_invoice_count
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    high_invoice_count = average_invoices + standard_deviation * 2
    @invoices_by_merchant.map do |merchant|
      if merchant[1].length > high_invoice_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end


  def bottom_merchants_by_invoice_count
    average_invoices = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    low_invoice_count = average_invoices - standard_deviation * 2
    @invoices_by_merchant.map do |merchant|
      if merchant[1].length < low_invoice_count
        @parent.merchants.find_by_id(merchant[0])
      end
    end.compact
  end

  def group_by_day
    @invoices.group_by do |invoice|
    invoice.created_at.strftime('%A')
    end
  end

  def average_invoices_per_day
    @invoices.length / 7
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
    ((matching_invoices.length.to_f / @invoices.length.to_f) * 100).round(2)
  end

  def group_transactions_by_invoice_id
    @parent.transactions.transactions.group_by do |transaction|
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
    merch_revenue = @parent.merchants.all.map do |merchant|
      { merchant => revenue_by_merchant(merchant.id)}
    end
      sorted_merchants = merch_revenue.sort_by do |merchant|
        merchant.values.pop
      end
       x = sorted_merchants[-x..-1].map do |merchant_hash|
        merchant_hash.keys
      end.flatten.reverse
    end



  def merchants_with_pending_invoices
    transactions_by_invoice_id = group_transactions_by_invoice_id
    pending_invoices = []
    transactions_by_invoice_id.each do |invoice|
      if invoice_paid_in_full?(invoice[0])
        next
      else
        pending_invoices << @parent.invoices.find_by_id(invoice[0])
      end
    end
    binding.pry
    pending_invoices.map do |invoice|
      @parent.merchants.find_by_id(invoice.merchant_id)
    end
  end

  def merchants_with_only_one_item
    #returns an array of merchants
  end

  def merchants_with_only_one_item_registered_in_month(month)
  end

  def group_invoice_items_by_items
    @parent.invoice_items.all.group_by do |invoice_item|
      invoice_item.item_id
    end
  end

  def calculates_revenue_per_item(item_id)
    invoice_items_by_item = group_invoice_items_by_items
    invoice_items_by_item[item_id].inject(0) do |revenue, invoice_item|
      revenue += invoice_item.quantity * invoice_item.unit_price
      revenue
    end
  end

  def revenue_by_merchant(merchant_id)
    items_by_merchant = group_items_by_merchant
    items_by_merchant[merchant_id].inject(0) do |revenue, item|
      revenue += calculates_revenue_per_item(item.id)
      revenue
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    #array of item
  end

  def best_item_for_merchant(merchant_id)
  end










end
