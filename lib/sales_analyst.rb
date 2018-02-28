require 'bigdecimal'
require 'date'
require_relative '../lib/statistics'
require_relative '../lib/data_set'

# This is the sales analyst class
class SalesAnalyst
  include Statistics
  include DataSet
  attr_reader :sales_engine,
              :merchant_repo,
              :item_repo,
              :invoice_repo,
              :transaction_repo,
              :invoice_item_repo,
              :customer_repo
  def initialize(sales_engine)
    @merchant_repo     = sales_engine.merchants
    @item_repo         = sales_engine.items
    @invoice_repo      = sales_engine.invoices
    @transaction_repo  = sales_engine.transactions
    @invoice_item_repo = sales_engine.invoice_items
    @customer_repo     = sales_engine.customers
  end

  def items_per_merchant
    @items_per_merchant ||= merchants.map do |merchant|
      merchant.items.count
    end
  end

  def invoices_per_merchant
    @invoices_per_merchant ||= merchants.map do |merchant|
      invoice_repo.find_all_by_merchant_id(merchant.id).count
    end
  end

  def average_items_per_merchant
    @average_items_per_merchant ||= average(
      items_per_merchant, merchants.length
    ).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @average_items_per_merch_stdev ||= stdev(
      items_per_merchant, average_items_per_merchant
    ).round(2)
  end

  def merchants_with_high_item_count
    merchants.find_all do |merchant|
      merchant.items.length > (
        average_items_per_merchant +
        average_items_per_merchant_standard_deviation
      )
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = merchant_repo.find_by_id(merchant_id)
    prices = merchant.items.map(&:unit_price)
    item_average_price = average(prices, prices.length)
    BigDecimal.new item_average_price, 4
  end

  def find_average_price(merchant)
    if merchant.items.empty?
      0
    else
      average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    prices = merchants.map { |merchant| find_average_price(merchant) }
    average_average_price = average(prices, prices.length)
    BigDecimal.new(average_average_price, 0).truncate 2
  end

  def item_unit_prices
    @item_unit_prices ||= items.map(&:unit_price)
  end

  def average_item_price
    @average_item_price ||= average(
      item_unit_prices, item_unit_prices.length.round(2)
    )
  end

  def item_price_standard_deviation
    @item_price_standard_deviation ||= stdev(
      item_unit_prices, average_item_price
    ).round(2)
  end

  def golden_items
    zipped = item_unit_prices.zip(items)
    average = average_item_price
    stdev = item_price_standard_deviation
    found = zipped.find_all { |item| item[0] > (average + (stdev * 2)) }
    found.map { |item| item[1] }
  end

  def average_invoices_per_merchant
    @average_invoices_per_merchant ||= average(
      invoices_per_merchant, invoices_per_merchant.length
    ).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    @average_invoices_per_merchant_stdev ||= stdev(
      invoices_per_merchant, average_invoices_per_merchant
    ).round(2)
  end

  def top_merchants_by_invoice_count
    zipped = invoices_per_merchant.zip(merchants)
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation
    found = zipped.find_all { |invoice| invoice[0] > (average + (stdev * 2)) }
    found.map { |invoice| invoice[1] }
  end

  def bottom_merchants_by_invoice_count
    zipped = invoices_per_merchant.zip(merchants)
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation
    found = zipped.find_all { |invoice| invoice[0] < (average - (stdev * 2)) }
    found.map { |invoice| invoice[1] }
  end

  def day_invoice_created
    @day_invoice_created ||= invoices.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def days_of_week_invoice_count
    days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    @days_of_week_invoice_count ||= days.map do |day|
      day_invoice_created.count(day)
    end
  end

  def average_invoices_per_day
    invoice_count = days_of_week_invoice_count
    @avg_invoices_per_day ||= average(
      invoice_count, invoice_count.length
    ).round(2)
  end

  def invoices_per_day_standard_deviation
    @invoices_per_day_stdev ||= stdev(
      days_of_week_invoice_count, average_invoices_per_day
    ).round(2)
  end

  def top_days_by_invoice_count
    days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    zipped = days_of_week_invoice_count.zip(days)
    average = average_invoices_per_day
    stdev = invoices_per_day_standard_deviation
    found = zipped.find_all { |invoice| invoice[0] > (average + (stdev * 1)) }
    found.map { |day| day[1] }
  end

  def invoice_status(status)
    numerator = invoice_repo.find_all_by_status(status).count.to_f
    denominator = invoices.count
    ((numerator / denominator) * 100).round 2
  end

  def total_revenue_by_date(date)
    invoices = invoice_repo.find_all_by_date(date)
    invoice_ids = invoices.find_all(&:is_paid_in_full?).map(&:id)
    invoice_items = invoice_ids.map do |invoice_id|
      invoice_item_repo.find_all_by_invoice_id(invoice_id)
    end.flatten
    invoice_items.map { |ii| ii.unit_price * ii.quantity }.reduce :+
  end

  def top_revenue_earners(num_merchants = 20)
    merchant_revenues = merchants.map do |merchant|
      revenue_by_merchant(merchant.id).to_f
    end
    zipped = merchants.zip(merchant_revenues).to_h
    sorted = zipped.max_by(num_merchants) { |_k, v| v }
    sorted.map { |subarray| subarray[0] }
  end

  def find_total_item_prices(invoice_item_array)
    invoice_item_array.map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_ids = invoices.find_all(&:is_paid_in_full?).map(&:id)
    invoice_items = invoice_item_repo.find_all_by_mult_invoice_ids(invoice_ids)
    invoice_items.flatten!
    find_total_item_prices(invoice_items).reduce :+
  end

  def merchants_total_revenue
    total_revenue = merchants.map do |merchant|
      revenue_by_merchant(merchant.id)
    end
    total_revenue.map { |num| num || 0 }
  end

  def merchants_ranked_by_revenue
    zipped = merchants.zip(merchants_total_revenue).to_h
    sorted = zipped.sort_by { |_k, v| v }
    sorted.map { |merchant| merchant[0] }.reverse
  end

  def merchants_with_pending_invoices
    pending_invoices = invoices.reject(&:is_paid_in_full?)
    merchant_ids = pending_invoices.map(&:merchant_id).uniq
    merchant_ids.map do |merchant_id|
      merchants.find_all { |merchant| merchant.id == merchant_id }
    end.flatten
  end

  def merchants_with_only_one_item
    merchant_items = merchants.map { |merchant| merchant.items.length }
    zipped = merchants.zip(merchant_items)
    only_one = zipped.find_all { |subarray| subarray[1] == 1 }
    only_one.map { |subarray| subarray[0] }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    all_merchants = merchants.find_all do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end
    item_count = all_merchants.map { |merchant| merchant.items.length }
    one = all_merchants.zip(item_count).find_all { |subarray| subarray[1] == 1 }
    one.map { |subarray| subarray[0] }
  end

  def most_sold_item_for_merchant(merchant_id)
    merchants_invoices = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchants_invoices.find_all(&:is_paid_in_full?).map(&:id)
    i_items = invoice_item_repo.find_all_by_mult_invoice_ids(invoice_ids)
    sorted = i_items.flatten.max_by(&:quantity).quantity
    highest_quantity = search_invoice_items_by_quantity(i_items.flatten, sorted)
    @item_repo.find_all_by_invoice_items(highest_quantity)
  end

  def search_invoice_items_by_quantity(invoice_item_array, quantity)
    invoice_item_array.find_all do |invoice_item|
      invoice_item.quantity == quantity
    end
  end

  def best_item_for_merchant(merchant_id)
    merchants_invoices = invoice_repo.find_all_by_merchant_id(merchant_id)
    invoice_ids = merchants_invoices.find_all(&:is_paid_in_full?).map(&:id)
    invoice_items = invoice_item_repo.find_all_by_mult_invoice_ids(invoice_ids)
    highest_revenue = sort_invoice_items_by_total_revenue(invoice_items)
    item_repo.find_by_id(highest_revenue.item_id)
  end

  def sort_invoice_items_by_total_revenue(invoice_items)
    invoice_items.flatten.max_by do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end

  def top_buyers(num_customers = 20)
    customers.max_by(num_customers) do |customer|
      invoice_costs = customer.fully_paid_invoices.map(&:total)
      invoice_costs.inject(:+).to_f
    end
  end

  def get_invoices_for_customer(customer_id)
    invoice_repo.find_all_by_customer_id(customer_id)
  end

  def top_merchant_for_customer(cust_id)
    top = customer_repo.find_by_id(cust_id).all_invoices.max_by do |invoice|
      quantities = invoice.invoice_items.map(&:quantity)
      quantities.inject(:+).to_f
    end.merchant_id
    merchant_repo.find_by_id(top)
  end

  def one_time_buyers
    customers.find_all do |customer|
      paid_invoices = customer.fully_paid_invoices
      paid_invoices.delete(false)
      paid_invoices.length == 1
    end
  end

  def one_time_buyers_top_items
    hash = Hash.new(0)
    one_time_buyers.each do |customer|
      find_fully_paid_invoices(customer, hash)
    end
    [hash.key(hash.values.sort.last)]
  end

  def find_fully_paid_invoices(customer, hash)
    customer.fully_paid_invoices.each do |invoice|
      find_quantities(invoice, hash)
    end
  end

  def find_quantities(invoice, hash)
    invoice.invoice_items.each do |invoice_item|
      hash[item_repo.find_by_id(invoice_item.item_id)] += invoice_item.quantity
    end
  end

  def items_bought_in_year(customer_id, year)
    all_invoices = invoices.find_all do |invoice|
      invoice.customer_id == customer_id && invoice.created_at.year == year
    end.flatten
    all_invoices.map(&:items).flatten.compact
  end

  def highest_volume_items(customer_id)
    customer = customer_repo.find_by_id(customer_id)
    occurances = customer.all_invoice_items.map(&:quantity)
    occurances.map.with_index do |num, index|
      next unless num == occurances.max
      item_repo.find_by_id(customer.all_invoice_items[index].item_id)
    end.compact
  end

  def customers_with_unpaid_invoices
    customers.find_all do |customer|
      customer_invoices = invoice_repo.find_all_by_customer_id(customer.id)
      invoice_status = customer_invoices.map(&:is_paid_in_full?)
      invoice_status.include?(false)
    end
  end

  def best_invoice_by_revenue
    paid_invoices = invoices.find_all(&:is_paid_in_full?)
    paid_invoices.max_by do |invoice|
      invoice.invoice_items.map do |ii|
        ii.unit_price * ii.quantity
      end.reduce(:+).to_f
    end
  end

  def best_invoice_by_quantity
    paid_invoices = invoices.find_all(&:is_paid_in_full?)
    paid_invoices.max_by do |invoice|
      invoice_items = invoice_item_repo.find_all_by_invoice_id(invoice.id)
      quantity = invoice_items.map(&:quantity)
      quantity.reduce(:+).to_f
    end
  end
end
