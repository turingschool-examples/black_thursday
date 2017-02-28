require_relative './sales_engine'
class SalesAnalyst
  attr_reader :engine, :all_item_prices, :average_price, :day_groups
  def initialize(engine)
    @engine = engine
  end

  def all_items
    engine.items.all
  end

  def all_merchants
    engine.merchants.all
  end

  def all_invoices
    engine.invoices.all
  end

  def merchant_items(merchant_id)
     engine.items.find_all_by_merchant_id(merchant_id)
  end

  def wday_groups
    all_invoices.group_by do |invoice|
      invoice.day_created
    end
  end

  def item_count
    all_items.count
  end

  def merchant_count
    all_merchants.count
  end

  def merchant_item_count(merchant)
    merchant.items.count
  end

  def merchant_invoice_counts
    all_merchants.map do |merchant|
      merchant.invoices.count
    end
  end


  def item_count_array(merchants)
    merchants.map do |merchant|
      merchant_item_count(merchant)
    end
  end

  def item_prices_array(items)
    items.map(&:unit_price)
  end

  def wday_invoice_count_array
    wday_groups.each_value.map(&:count)
  end

  def find_average(numerator, denomenator)
    (numerator / denomenator)
  end

  def average_items_per_merchant
    find_average(item_count.to_f, merchant_count.to_f).round(2)
  end

  def average_item_price_for_merchant(merchant_id, items = merchant_items(merchant_id))
    find_average(item_prices_array(items).inject(:+), items.count).round(2)
  end

  def average_average_price_per_merchant
    combined_average = all_merchants.inject(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    find_average(combined_average, all_merchants.count).round(2)
  end

  def average_item_price
    find_average(item_prices_array(all_items).inject(:+), item_count).round(2)
  end

  def average_invoices_per_day
    find_average(all_invoices.count.to_f, wday_groups.keys.count).round(2)
  end

  def average_invoices_per_merchant
    find_average(all_invoices.count.to_f, merchant_count.to_f).round(2)
  end

  def find_standard_deviation(average, number_array)
    sum = number_array.inject(0) do |total, count|
      total + (count - average)**2
    end
    Math.sqrt(sum / (number_array.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    find_standard_deviation(average_items_per_merchant, item_count_array(all_merchants))
  end

  def average_item_price_standard_deviation
    find_standard_deviation(average_item_price, item_prices_array(all_items))
  end

  def average_invoices_per_merchant_standard_deviation
    find_standard_deviation(average_invoices_per_merchant, merchant_invoice_counts)
  end

  def average_invoices_per_day_standard_deviation
    find_standard_deviation(average_invoices_per_day, wday_invoice_count_array)
  end

  def merchants_with_high_item_count(average = average_items_per_merchant, sd = average_items_per_merchant_standard_deviation)
    all_merchants.find_all do |merchant|
      merchant_item_count(merchant) > average + sd
    end
  end

  def golden_items(average = average_item_price, sd = average_item_price_standard_deviation)
    all_items.find_all do |item|
      item.unit_price > average + sd * 2
    end
  end

  def top_merchants_by_invoice_count(average = average_invoices_per_merchant, sd = average_invoices_per_merchant_standard_deviation)
    all_merchants.find_all do |merchant|
      merchant.invoices.count > average + 2 * sd
    end
  end

  def bottom_merchants_by_invoice_count(average = average_invoices_per_merchant, sd = average_invoices_per_merchant_standard_deviation)
    all_merchants.find_all do |merchant|
      merchant.invoices.count < average - 2 * sd
    end
  end

  def top_days_by_invoice_count(average = average_invoices_per_day, sd = average_invoices_per_day_standard_deviation)
    wday_groups.select do |_day, invoices|
      invoices.count > average + sd
    end.keys
  end

  def invoice_status(status)
    status_count = all_invoices.count do |invoice|
      invoice.status == status
    end
    (100 * status_count.to_f / all_invoices.count.to_f).round(2)
  end

  def total_revenue_by_date(date)
    invoices_from_date(date).reduce(0) do |sum, invoice|
      sum + invoice.total
    end
  end

  def invoices_from_date(date)
    engine.invoices.find_all_by_created_date(date)
  end

  def top_revenue_earners(x = 20, revenues = revenues_for_all_merchants)
    top_earners = revenues.to_a.max_by(x) { |merchantrev| merchantrev[1] }
    top_earners.map! { |merchantrev| merchantrev[0] }
    top_earners.map! { |merchant_id| engine.merchants.find_by_id(merchant_id) }
  end

  def revenues_for_all_merchants(grouped = invoices_grouped_by_merchant)
    merchant_revenues = {}
    grouped.each do |key, value|
      merchant_revenues[key] = value.inject(0) do |sum, invoice|
        sum + invoice.total
      end
    end
    merchant_revenues
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(all_merchants.count)
  end

  def invoices_grouped_by_merchant
    all_invoices.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def pending_invoices
    all_invoices.find_all { |invoice| !invoice.is_paid_in_full? }
  end

  def merchants_with_pending_invoices(pending = pending_invoices)
    merchant_list = pending.map(&:merchant_id).uniq
    merchant_list.map do |merchant_id|
      engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item
    all_merchants.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    all_merchants.find_all do |merchant|
      merchant.items.count == 1 && merchant.month_created.downcase == month_name.downcase
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices_grouped_by_merchant[merchant_id].inject(0) do |sum, invoice|
      sum + invoice.total
    end
  end

  def find_invoice_items_for_merchant(merchant_id)
    invoices = engine.merchants.find_by_id(merchant_id).invoices.find_all do |invoice|
      invoice.is_paid_in_full?
    end
    invoices.map do |invoice|
      invoice.invoice_items
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    group = find_quantity_for_each_item_id(merchant_id)
    max = group.max_by { |_, v| v }[1]

    highest = group.select {|_, v| v == max}.to_a
    highest.map! {|array| engine.items.find_by_id(array[0])}
  end

  def group_by_item_id(merchant_id)
    inv_items = find_invoice_items_for_merchant(merchant_id).flatten
    inv_items.group_by do |inv_item|
      inv_item.item_id
    end
  end

  def find_quantity_for_each_item_id(merchant_id)
    group = group_by_item_id(merchant_id)
    group.each do |k,v|
      group[k] = v.reduce(0){|sum, item| sum + item.quantity}
    end
  end

  def find_revenue_for_each_item_id(merchant_id)
    group = group_by_item_id(merchant_id)
    group.each do |k,v|
      group[k] = v.reduce(0){|sum, item| sum + item.quantity * item.unit_price}
    end
  end

  def best_item_for_merchant(merchant_id)
    group = find_revenue_for_each_item_id(merchant_id)
    max = group.max_by { |_, v| v }[1]

    highest = group.select {|_, v| v == max}.to_a
    highest.map! {|array| engine.items.find_by_id(array[0])}[0]
  end
end

#
# se = SalesEngine.from_csv({
#     :items => "./data/items.csv",
#     :merchants => "./data/merchants.csv",
#     :invoices => "./data/invoices.csv",
#     :invoice_items => "./data/invoice_items.csv",
#     :transactions => "./data/transactions.csv",
#     :customers => "./data/customers.csv"
#     })
# sa = SalesAnalyst.new(se)
# require "pry"; binding.pry
# puts  sa.most_sold_item_for_merchant(12337105)
