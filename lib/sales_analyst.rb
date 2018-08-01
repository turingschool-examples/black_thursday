require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require 'time'
require 'bigdecimal'

class SalesAnalyst

  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def initialize(merchant_repo, item_repo, invoice_repo, invoice_item_repo, transaction_repo, customer_repo)
    @merchants = merchant_repo
    @items = item_repo
    @invoices = invoice_repo
    @invoice_items = invoice_item_repo
    @transactions = transaction_repo
    @customers = customer_repo
  end

  def average_items_per_merchant
    total_items = @items.all.count.to_f
    total_merchants = @merchants.all.count.to_f
    (total_items / total_merchants).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = @items.find_all_by_merchant_id(merchant_id)
    total_prices = total_items.inject(0) do |sum, item|
      sum += item.unit_price
    end
    average_item_price = total_prices / total_items.count
    average_item_price.round(2)
  end

  def average_average_price_per_merchant
    average_summed = all_average_prices.inject(0) do |sum, price|
      sum += price
    end
    average_average_price = average_summed / @merchants.all.count
    average_average_price.round(2)
  end

  def average_item_price
    prices_summed = @items.all.inject(0) do |sum, item|
      sum += item.unit_price
    end
    prices_summed / @items.all.count
  end

  def all_average_prices
    average_prices = @merchants.all.map do |merchant|
      merchant_id = merchant.id
      average_item_price_for_merchant(merchant_id)
    end
  end

  def all_item_prices
   @items.all.map do |item|
    item.unit_price
    end
  end

  def return_unique_merchants
    if @merchants != nil
      return @merchants.all.uniq do |merchant|
        merchant.id
      end
    end
  end

  def total_items_per_merchant
    merchants = return_unique_merchants
    merchant_item_total = []
    merchants.each do |merchant|
      merchant_items = @items.all.find_all do |item|
        item.merchant_id == merchant.id
      end
      merchant_item_total << merchant_items.count
    end
    merchant_item_total
  end

  def differences_from_average(array, average)
    array.map do |amount|
      amount.to_f - average
    end
  end

  def square_each_amount(array)
    array.map do |amount|
      amount * amount
    end
  end

  def sum_amount(array)
    array.inject(0) do |sum, amount|
      sum += amount
    end
  end

  def divide_sum_by_elements_less_one(elements, sum)
    sum / (elements.all.count - 1)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(total_items_per_merchant, average_items_per_merchant, @merchants)
  end

  def standard_deviation_prices
    standard_deviation(all_item_prices, average_item_price, @items)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(array_invoices_per_merchant, average_invoices_per_merchant, @merchants)
  end

  def standard_deviation(array, average, collection)
    differences = differences_from_average(array, average)
    squares = square_each_amount(differences)
    sum = sum_amount(squares)
    result = divide_sum_by_elements_less_one(collection, sum)
    result = Math.sqrt(result).round(2)
  end

  def merchants_ids_for_high_item_count
    high_item_count = average_items_per_merchant_standard_deviation + average_items_per_merchant
    id_count_pair = return_unique_merchants.zip(total_items_per_merchant)
    merchant_ids = id_count_pair.find_all do |pair|
      if pair[1] >= high_item_count
        pair[0]
      end
    end
  end

  def merchants_with_high_item_count
    pairs = merchants_ids_for_high_item_count
    pairs.map do |pair|
      pair.reverse
      pair.pop
    end
    pairs.flatten
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = @items.find_all_by_merchant_id(merchant_id)
    total_prices = total_items.inject(0) do |sum, item|
      sum += item.unit_price
    end
    average_item_price = total_prices / total_items.count
    average_item_price.round(2)
  end

  def all_average_prices
    average_prices = @merchants.all.map do |merchant|
      merchant_id = merchant.id
      average_item_price_for_merchant(merchant_id)
    end
  end

  def average_average_price_per_merchant
    average_summed = all_average_prices.inject(0) do |sum, price|
      sum += price
    end
  end

  def golden_items
    high_item_price = standard_deviation_prices * 2 + average_item_price
    golden = []
    @items.all.each do |item|
      if item.unit_price >= high_item_price
        golden << item
      end
    end
    golden
  end

  def average_item_price
    prices_summed = @items.all.inject(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_invoices_per_merchant
    average = @invoices.all.count.to_f / @merchants.all.count
    average.round(2)
  end

  def array_invoices_per_merchant
    array = []
    @merchants.all.each do |merchant|
      id = merchant.id
      all_invoices = @invoices.find_all_by_merchant_id(id)
      array << all_invoices.count
    end
    array
  end

  def all_item_prices
    @items.all.map do |item|
     item.unit_price
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(array_invoices_per_merchant, average_invoices_per_merchant, @invoices)
  end

  def top_merchants_by_invoice_count
    high_level = average_invoices_per_merchant_standard_deviation * 2 + average_invoices_per_merchant
    unique_merchants = @merchants.all.uniq
    top_merchants = []
    unique_merchants.each do |merchant|
      id = merchant.id
      all_invoices = @invoices.find_all_by_merchant_id(id)
      count = all_invoices.count
      if count >= high_level
        top_merchants << merchant
      end
    end
    top_merchants
  end


  def differences_from_average_price
    all_item_prices.map do |price|
      price.to_f - average_item_price
    end
  end

  def bottom_merchants_by_invoice_count
    low_level = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    unique_merchants = @merchants.all.uniq
    low_merchants = []
    unique_merchants.each do |merchant|
      id = merchant.id
      all_invoices = @invoices.find_all_by_merchant_id(id)
      count = all_invoices.count
      if count <= low_level
        low_merchants << merchant
      end
    end
    low_merchants
  end

  def square_differences
    differences_from_average_price.map do |amount|
      amount * amount
    end
  end

  def sum_prices
    square_differences.inject(0) do |sum, amount|
      sum += amount
    end
  end

  def standard_deviation
    differences_from_average_price
    square_differences
    sum_prices
    result = sum_prices/ (@items.all.count - 1)
    result = Math.sqrt(result).round(2)
  end

  def days_array
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def average_invoices_per_day
    total_invoices = @invoices.all.count.to_f
    total_days = 7.0
    (total_invoices / total_days).round(2)
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(average_days_occurrence_array, average_invoices_per_day, @invoices)
  end

  def average_days_occurrence_array
    days = days_array
    days = days.map do |day|
      occurrences = @invoices.find_all_by_day(day)
      occurrences = occurrences.count
      occurrences
    end
    days
  end

  def average_days
    days = average_days_occurrence_array
    days = days.inject(0) do |sum, num|
      sum += num
    end
    days = days / 7.0
    days.round(2)
  end

  def top_days_by_invoice_count
    high_level = average_invoices_per_day_standard_deviation + average_days
    golden = []
    average_days_occurrence_array.each_with_index do |day, index|
      if day >= high_level
        golden << [days_array[index]]
      end
    end
    golden
  end

  def invoice_status(sym)
    percentage = @invoices.find_all_by_status(sym).count.to_f / @invoices.all.count
    percentage = percentage * 100
    percentage.round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transactions.find_all_by_invoice_id(invoice_id)
    transactions.any? {|transaction| transaction.result.to_s == "success"}
  end

  def invoice_total(invoice_id)
    invoices = @invoice_items.find_all_by_invoice_id(invoice_id)
    invoices.inject(0) do |total, invoice|
      total += (invoice.quantity * invoice.unit_price)
    end
  end

  def total_revenue_by_date(date)
   all_invoices = @invoices.invoices.find_all do |invoice|
     invoice.created_at.to_s[0...10] == date.to_s[0...10]
   end
   invoice_ids = all_invoices.map do |invoice|
     invoice.id
   end
   total_revenue(invoice_ids)
  end

  def total_revenue(invoice_ids)
   invoice_ids.inject(0) do |total, invoice_id|
     total += invoice_total(invoice_id.to_f)
   end
  end

  def invoices_grouped_by_merchant
    @invoices.invoices.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def revenue_per_merchant
    merchants = {}
    invoices_grouped_by_merchant.each do |merchant_id, invoices|
      merchants[merchant_id] = invoices.map do |invoice|
        invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
      end.compact.inject(:+)
    end
    merchants
  end

  def hash_to_array(hash)
  values_sorted = hash.values.sort
  value_array = []
  values_sorted.each do |value|
    hash.each do |name, amount|
      value_array << name if amount == value
    end
  end
  value_array.uniq
  end

  def delete_nils(hash)
    hash.delete_if do |key, value|
      value.nil?
    end
  end

  def top_revenue_earners(x = 20)
    merchants_revenue = delete_nils(revenue_per_merchant)
    merchants_revenue.keep_if do |merchant_id, revenue|
     merchants_revenue.values.sort[-x..-1].include?(revenue)
    end
    hash_to_array(merchants_revenue).map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end.reverse
  end

  def get_unsuccessful_invoices
    invoices = @invoices.all
    list = []
    invoices.map do |invoice|
      if !invoice_paid_in_full?(invoice.id)
        list << invoice
      end
    end
    list
  end

  def merchants_with_pending_invoices
    invoices = get_unsuccessful_invoices
    merchants =invoices.map do |invoice|
        invoice = @merchants.find_by_id(invoice.merchant_id)
    end.uniq
    merchants
  end

  def merchants_with_only_one_item
    array = []
    @merchants.all.each do |merchant|
      items = @items.find_all_by_merchant_id(merchant.id)
      if items.count == 1
        array << merchant
      end
    end
    array.uniq
  end

  def merchants_with_only_one_item_registered_in_month(month)
    array = []
    @merchants.all.each do |merchant|
      items = @items.find_all_by_merchant_id(merchant.id)
      if items.count == 1 && merchant.created_at.strftime('%B') == month
        array << merchant
      end
    end
    array.uniq
  end

  def top_items_per_merchant(merchant_id)
    invoices = @invoices.find_all_by_merchant_id(merchant_id)
    invoices.keep_if { |invoice| invoice_paid_in_full?(invoice.id) }
    invoices.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def top_item(hash)
    max_item_value = hash.values.max
    hash.keep_if do | key, value|
      value == max_item_value
    end
    hash.keys.map do |item_id|
      @items.find_by_id(item_id)
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    item_quantities = Hash.new(0)
    top_items_per_merchant(merchant_id).map do |invoice_item|
      item_quantities[invoice_item.item_id] += invoice_item.quantity
    end
    top_item(item_quantities)
  end

  def invoice_items_total_price(array)
    invo_items = Hash.new(0)
    array.map do |invoice_item|
      total = (invoice_item.unit_price * invoice_item.quantity)
      invo_items[invoice_item.item_id] += total
    end
    invo_items
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = top_items_per_merchant(merchant_id)
    item_prices = invoice_items_total_price(invoice_items)
    top_item(item_prices).first
  end

end
