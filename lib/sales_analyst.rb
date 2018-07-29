require 'time'
require 'pry'
require 'date'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(items, merchants, invoices, transactions, invoice_items, customers)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @transactions = transactions
    @invoice_items = invoice_items
    @customers = customers
  end

  def average_items_per_merchant
    (@items.all.count.to_f / @merchants.all.count).round(2)
  end

  def average(total, number_of_elements)
    (average = total / number_of_elements.count).round(2)
  end

  def standard_deviation(elements, element_average)
    difference_squared = elements.map do |element|
      (element - element_average) ** 2
    end
    summed_differences = difference_squared.inject(:+)
    sum = summed_differences / (elements.count - 1)
    std_dev = Math.sqrt(sum).round(2)
  end

  def standard_deviation_of_prices
    all_prices = @items.all.map do |item|
      item.unit_price
    end
    standard_deviation(all_prices, average_of_item_prices).to_s.to_d
  end

  def average_items_per_merchant_standard_deviation
    merchant_ids = find_all_merchant_ids
    items_from_each_merchant = get_number_of_items_from_merchants(merchant_ids)
    standard_deviation(items_from_each_merchant, average_items_per_merchant)
  end

  def find_all_merchant_ids
    @merchants.all.map do |merchant|
      merchant.id
    end
  end

  def get_number_of_items_from_merchants(merchant_ids)
    merchant_ids.map do |merchant_id|
      @items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def merchants_with_high_item_count
    high_item_indicator = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_seller_ids = find_all_merchant_ids.find_all do |merchant_id|
      @items.find_all_by_merchant_id(merchant_id).count >= high_item_indicator
    end
    high_seller_ids.map do |id|
      @merchants.find_by_id(id)
    end
  end

  def average_item_price_for_merchant(id)
    merchants_items = @items.find_all_by_merchant_id(id)
    summed_price_of_items = merchants_items.inject(0) do |sum, item|
      sum += item.unit_price
    end
    average(summed_price_of_items, merchants_items)
  end

  def average_average_price_per_merchant
    average_prices = find_all_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end
    average_all_prices = average_prices.inject(0) do |sum, price|
      sum += price
    end
    average(average_all_prices, average_prices)
  end

  def average_of_item_prices
    total_of_prices = (@items.all).inject(0) do |sum, item|
      sum += item.unit_price
    end
    average(total_of_prices, @items.all)
  end

  def golden_items
    golden_standard_price = average_of_item_prices + (2 * standard_deviation_of_prices)
    @items.all.find_all do |item|
      item.unit_price >= golden_standard_price
    end
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_ids = find_all_merchant_ids
    invoices_from_each_merchant = get_number_of_invoices_from_merchants(merchant_ids)
    standard_deviation(invoices_from_each_merchant, average_invoices_per_merchant)
  end

  def average_invoices_per_merchant
    (@invoices.all.count.to_f / @merchants.all.count).round(2)
  end

  def get_number_of_invoices_from_merchants(merchant_ids)
    merchant_ids.map do |merchant_id|
      @invoices.find_all_by_merchant_id(merchant_id).count
    end
  end

  def top_merchants_by_invoice_count
    top_invoice_number = average_invoices_per_merchant + (2 * average_invoices_per_merchant_standard_deviation)
    top_performing_merchants = find_all_merchant_ids.find_all do |merchant_id|
      @invoices.find_all_by_merchant_id(merchant_id).count > top_invoice_number
    end
    top_performing_merchants.map do |id|
      @merchants.find_by_id(id)
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_invoice_number = average_invoices_per_merchant - (2 * average_invoices_per_merchant_standard_deviation)
    top_performing_merchants = find_all_merchant_ids.find_all do |merchant_id|
      @invoices.find_all_by_merchant_id(merchant_id).count < bottom_invoice_number
    end
    top_performing_merchants.map do |id|
      @merchants.find_by_id(id)
    end
  end

  def weekday_breakdown
    @invoices.all.inject(Hash.new(0)) do |days, invoice|
      days[invoice.created_at.strftime("%A")] += 1
      days
    end
  end

  def top_days_by_invoice_count
    average_by_day = @invoices.all.count / 7
    st_dev_days = standard_deviation(weekday_breakdown.values, average_by_day)
    top_day_invoice_number = average_by_day + st_dev_days
    top_pairs = weekday_breakdown.find_all do |day, number|
      if number >= top_day_invoice_number
        day
      end
    end.flatten
    top_pairs.find_all do |days|
      days.class == String
    end
  end

  def invoice_status(status)
    status_count = @invoices.all.each_with_object(Hash.new(0)) do |invoice, statuses|
      statuses[invoice.status] += 1
    end
    ((status_count[status].to_f / @invoices.all.count) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    if @transactions.find_all_by_invoice_id(invoice_id) == []
      false
    else
      transactions = @transactions.find_all_by_invoice_id(invoice_id)
      transactions.all? do |transaction|
        transaction.result == :success
      end
    end
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id)
      matched_invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
      matched_invoice_items.inject(0) do |total, invoice_item|
        total += invoice_item.unit_price * invoice_item.quantity
      end
    end
  end

  def revenue_by_merchant(merchant_id)
    merchants_invoices = @invoices.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchants_invoices.map do |invoice|
      invoice.id
    end
    invoice_ids.inject(0) do |sum, invoice_id|
      if invoice_paid_in_full?(invoice_id)
        sum += invoice_total(invoice_id)
      end
      sum
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices_for_items = find_merchant_invoice_items_by_item(merchant_id)
    item_counts = invoices_for_items.inject(Hash.new(0)) do |count, invoice|
      count[invoice.item_id] += invoice.quantity
      count
    end
    max_sold = item_counts.values.max
    top_item_ids = item_counts.find_all do |item, number|
      number == max_sold
    end
    top_item_ids.map do |item_id|
      @items.find_by_id(item_id[0])
    end
  end

  def find_merchant_invoice_items_by_item(merchant_id)
    merchants_items = @items.find_all_by_merchant_id(merchant_id)
    item_ids = merchants_items.map do |merchant_item|
      merchant_item.id
    end
    item_ids.map do |item_id|
      @invoice_items.find_all_by_item_id(item_id)
    end.flatten
  end

  # def best_item_for_merchant(merchant_id)
  #   invoices_for_items = find_merchant_invoice_items_by_item(merchant_id)
  #   paid_invoices = invoices_for_items.find_all do |invoice_item|
  #     invoice_paid_in_full?(invoice_item.id)
  #   end
  #   item_revenue = paid_invoices.inject(Hash.new(0)) do |revenue, invoice|
  #     revenue[invoice.item_id] += (invoice.quantity * invoice.unit_price)
  #     revenue
  #   end
  #   top_item_revenue = item_revenue.values.max
  #   item_revenue.map do |item_id|
  #     @items.find_by_id(item_id[0])
  #   end
  # end

  def merchants_with_only_one_item
    merchant_ids = find_all_merchant_ids
    one_item_ids = merchant_ids.find_all do |merchant_id|
      (@items.find_all_by_merchant_id(merchant_id)).count == 1
    end
    one_item_ids.map do |id|
      @merchants.find_by_id(id)
    end
  end

end
