require_relative 'sales_engine.rb'
require 'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    sum = items_per_merchant.inject(:+)
    (sum / items_per_merchant.length.round(2)).round(2)
  end

  def items_per_merchant_standard_dev
    standard_deviation(items_per_merchant, average_items_per_merchant)
  end

  def standard_deviation(array, average)
    count_less_one = (array.count - 1)
    sum = array.reduce(0.0) { |total, amount| total + (amount - average)**2 }
    ((sum / count_less_one)**(1.0 / 2)).round(2)
  end

  def items_grouped_by_merchant
    @se.items.all.group_by(&:merchant_id)
  end

  def items_per_merchant
    items_grouped_by_merchant.values.map(&:count)
  end

  def id_counts
    items_grouped_by_merchant.keys.zip(items_per_merchant)
  end

  def merchants_with_high_item_count
    high_count = average_items_per_merchant + items_per_merchant_standard_dev
    id_counts.map do |id, count|
      @se.merchants.find_by_id(id) if count >= high_count
    end.compact
  end

  def average_item_price_for_merchant(id)
    items = @se.items.find_all_by_merchant_id(id)
    sum = items.reduce(0) { |total, item| total + item.unit_price }
    (sum / items.count).round(2)
  end

  def average_average_price_per_merchant
    sum = @se.merchants.all.reduce(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    (sum / @se.merchants.repository.count).round(2)
  end

  def average_item_prices_for_each_merchant
    @se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def item_price_standard_deviation
    standard_deviation(all_item_prices, average_total_item_price).round(2)
  end

  def all_item_prices
    @se.items.all.map(&:unit_price)
  end

  def average_total_item_price
    sum = @se.items.all.reduce(0) do |total, item|
      total + item.unit_price
    end
    sum / @se.items.all.count
  end

  def golden_items
    high_price = average_total_item_price + (item_price_standard_deviation * 2)
    @se.items.all.each_with_object([]) do |item, array|
      array << item if item.unit_price >= high_price
      array
    end
  end

  def invoices_grouped_by_merchant
    @se.invoices.all.group_by(&:merchant_id)
  end

  def invoices_per_merchant
    invoices_grouped_by_merchant.values.map(&:count)
  end

  def average_invoices_per_merchant
    sum = invoices_per_merchant.inject(:+)
    (sum.to_f / invoices_per_merchant.length).round(2)
  end

  def invoices_per_merchant_stand_dev
    standard_deviation(invoices_per_merchant, average_invoices_per_merchant)
  end

  def invoice_counts_for_each_merhant
    counts_for_merchant = {}
    invoices_grouped_by_merchant.each do |id, invoices|
      counts_for_merchant[id] = invoices.count
    end
    counts_for_merchant
  end

  def top_merchants_by_invoice_count
    high = average_invoices_per_merchant + (invoices_per_merchant_stand_dev * 2)
    invoice_counts_for_each_merhant.map do |id, count|
      @se.merchants.find_by_id(id) if count > high
    end.compact
  end

  def bottom_merchants_by_invoice_count
    low = average_invoices_per_merchant - (invoices_per_merchant_stand_dev * 2)
    invoice_counts_for_each_merhant.map do |id, count|
      @se.merchants.find_by_id(id) if count < low
    end.compact
  end

  def invoices_grouped_by_day
    @se.invoices.all.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def invoices_per_day
    invoices_grouped_by_day.values.map(&:count)
  end

  def average_invoices_per_day
    sum = invoices_per_day.inject(:+)
    (sum.to_f / invoices_per_day.length).round(2)
  end

  def invoices_per_day_standard_deviation
    standard_deviation(invoices_per_day, average_invoices_per_day)
  end

  def invoice_counts_for_each_day
    invoice_counts_for_day = {}
    invoices_grouped_by_day.each do |day, invoices|
      invoice_counts_for_day[day] = invoices.count
    end
    invoice_counts_for_day
  end

  def top_days_by_invoice_count
    high_count = average_invoices_per_day + invoices_per_day_standard_deviation
    invoice_counts_for_each_day.map do |day, count|
      day if count > high_count
    end.compact
  end

  def invoices_grouped_by_status
    @se.invoices.all.group_by(&:status)
  end

  def invoice_counts_for_each_status
    counts_for_status = {}
    invoices_grouped_by_status.each do |status, invoices|
      counts_for_status[status] = invoices.count
    end
    counts_for_status
  end

  def invoice_status(status)
    count = invoice_counts_for_each_status[status].to_f
    total = @se.invoices.all.count.to_f
    ((count / total) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    related_transactions = @se.transactions.find_all_by_invoice_id(invoice_id)
    related_transactions.any? { |transaction| transaction.result == :success }
  end

  def invoice_total(invoice_id)
    related_invoice_items = @se.invoice_items.find_all_by_invoice_id(invoice_id)
    costs = related_invoice_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
    number = costs.inject(0) do |total, cost|
      total + cost
    end
    BigDecimal(number, 7)
  end

  def total_revenue_by_date(date)
    invoices = find_all_invoices_created_at_date(date)
    invoices.inject(0) do |total, invoice|
      total += invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
      total
    end
  end

  def find_all_invoices_created_at_date(date)
    @se.invoices.all.select do |invoice|
      if invoice.created_at.strftime('%d%m%y') == date.strftime('%d%m%y')
        invoice
      end
    end
  end

  def total_revenue_for_each_merchant
    earners = {}
    invoices_grouped_by_merchant.each do |merchant_id, invoices|
      earners[merchant_id] = invoices.map do |invoice|
        invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
      end.compact.inject(:+)
    end
    earners
  end

  def compact_for_hash(hash)
    hash.delete_if { |_key, value| value.nil? }
  end

  def hash_to_array_ordered_by_value(hash)
    sorted_values = hash.values.sort
    array = []
    sorted_values.each do |value|
      hash.each do |key, pair_value|
        array << key if pair_value == value
      end
    end
    array.uniq
  end

  def top_revenue_earners(num = 20)
    merchants_with_a_sale = compact_for_hash(total_revenue_for_each_merchant)
    merchants_with_a_sale.keep_if do |_merchant_id, earned|
      merchants_with_a_sale.values.sort[-num..-1].include?(earned)
    end
    hash_to_array_ordered_by_value(merchants_with_a_sale).map do |merchant_id|
      @se.merchants.find_by_id(merchant_id)
    end.reverse
  end

  def revenue_by_merchant(merchant_id)
    total_revenue_for_each_merchant[merchant_id]
  end

  def merchants_with_pending_invoices
    merchant_ids = @se.invoices.all.map do |invoice|
      invoice.merchant_id unless invoice_paid_in_full?(invoice.id)
    end.compact
    merchant_ids.map do |merchant_id|
      @se.merchants.find_by_id(merchant_id)
    end.uniq
  end

  def merchants_with_only_one_item
    merchants = id_counts.delete_if do |array|
      array[1] != 1
    end
    merchants.map do |merchant|
      @se.merchants.find_by_id(merchant[0])
    end
  end

  def invoices_grouped_by_month
    @se.invoices.all.group_by do |invoice|
      invoice.created_at.strftime('%B')
    end
  end

  def merchants_grouped_by_month
    @se.merchants.all.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_in_month = merchants_grouped_by_month[month]
    one_item_in_month = merchants_with_only_one_item.select do |merchant|
      merchants_in_month.include?(merchant)
    end
    one_item_in_month
  end

  def successful_invoice_items_per_merchant_id(merchant_id)
    all_invoices = @se.invoices.find_all_by_merchant_id(merchant_id)
    all_invoices.keep_if { |invoice| invoice_paid_in_full?(invoice.id) }
    all_invoices.map do |invoice|
      @se.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def high_item_from_item_ids_with_values(hash)
    high_item_value = hash.values.max
    hash.keep_if { |_key, value| value == high_item_value }
    hash.keys.map { |item_id| @se.items.find_by_id(item_id) }
  end

  def most_sold_item_for_merchant(merchant_id)
    item_id_quantities = Hash.new(0)
    successful_invoice_items_per_merchant_id(merchant_id).map do |invoice_item|
      item_id_quantities[invoice_item.item_id] += invoice_item.quantity
    end
    high_item_from_item_ids_with_values(item_id_quantities)
  end

  def invoice_items_with_total_price(array)
    invoice_items_with_price = Hash.new(0)
    array.map do |invoice_item|
      total = (invoice_item.unit_price * invoice_item.quantity)
      invoice_items_with_price[invoice_item.item_id] += total
    end
    invoice_items_with_price
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = successful_invoice_items_per_merchant_id(merchant_id)
    item_id_unit_prices = invoice_items_with_total_price(invoice_items)
    high_item_from_item_ids_with_values(item_id_unit_prices).first
  end

  def change_nil_values_to_zero(hash)
    new_hash = {}
    hash.each do |key, value|
      value = 0 if value.nil?
      new_hash[key] = value
    end
    new_hash
  end

  def merchants_ranked_by_revenue
    total_revenues = change_nil_values_to_zero(total_revenue_for_each_merchant)
    sorted_merchants = total_revenues.to_a.sort_by do |merchant|
      merchant[1]
    end.reverse
    sorted_merchants.map { |merchant| @se.merchants.find_by_id(merchant[0]) }
  end
end
