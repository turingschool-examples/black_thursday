require 'bigdecimal'
require 'bigdecimal/util'

class SalesAnalyst

  def initialize(engine)
    @engine = engine
    @days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
             "Friday", "Saturday"]

  end

  def average_items_per_merchant
    (@engine.items.all.count.to_f / @engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_counts = get_item_count_from_merchants
    squared = square_counts(item_counts)
    sum = squared.inject(:+)
    divided = sum / (@engine.merchants.all.count - 1)
    Math.sqrt(divided).round(2)
  end

  def get_item_count_from_merchants
    @engine.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def square_counts(item_counts)
    item_counts.map do |count|
      (count - average_items_per_merchant) ** 2
    end
  end

  def merchants_with_high_item_count
    bar = average_items_per_merchant +
          average_items_per_merchant_standard_deviation
    @engine.merchants.all.find_all do |merchant|
      merchant.items.count > bar
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    sum = merchant.items.inject(0) do |total, item|
      total += item.unit_price/100
    end
    (sum / merchant.items.count * 100).round(2)
  end

  def average_average_price_per_merchant
    average_prices = @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (average_prices.reduce(:+) / @engine.merchants.all.count).truncate(2)
  end

  def average_item_price
    prices = @engine.items.items.map do |item|
      item.unit_price
    end
    prices.inject(:+) / @engine.items.items.count
  end

  def item_price_standard_deviation
    squared = @engine.items.items.map do |item|
      (item.unit_price - average_item_price) ** 2
    end
    divided = squared.inject(:+) / (@engine.items.items.count - 1)
    Math.sqrt(divided)
  end

  def golden_items
    bar = (2 * item_price_standard_deviation) + average_item_price
    @engine.items.items.find_all do |item|
      item.unit_price > bar
    end
  end

  def average_invoices_per_merchant
    (@engine.invoices.all.count.to_f /
    @engine.merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    squared  = @engine.merchants.all.map do |merchant|
      (merchant.invoices.count - average_invoices_per_merchant) ** 2
    end
    divided = squared.inject(:+) / (@engine.merchants.merchants.count - 1)
    (Math.sqrt(divided)).round(2)
  end

  def top_merchants_by_invoice_count
    bar = (2 * average_invoices_per_merchant_standard_deviation) +
          average_invoices_per_merchant
    @engine.merchants.merchants.find_all do |merchant|
      merchant.invoices.count > bar
    end
  end

  def bottom_merchants_by_invoice_count
    bar = average_invoices_per_merchant -
          (2 * average_invoices_per_merchant_standard_deviation)
    @engine.merchants.merchants.find_all do |merchant|
      merchant.invoices.count < bar
    end
  end

  def average_invoices_created_per_day
    @engine.invoices.invoices.count / 7
  end

  def number_of_invoices_created_per_day
    @days.map do |day|
      @engine.invoices.invoices.find_all do |invoice|
        invoice.created_day == day
      end.count
    end
  end

  def number_of_invoices_created_per_day_standard_deviation
    squared = number_of_invoices_created_per_day.map do |day|
      (day - average_invoices_created_per_day) ** 2
    end
    divided = squared.inject(:+).to_f / 6
    Math.sqrt(divided)
  end

  def top_days_by_invoice_count
    days = []
    bar = average_invoices_created_per_day +
          number_of_invoices_created_per_day_standard_deviation
    number_of_invoices_created_per_day.each.with_index do |invoice_count, index|
      if invoice_count > bar
        days << index
      end
    end
    translate_days(days)
  end

  def translate_days(array)
    array.map do |value|
      @days[value]
    end
  end

  def total_invoices_count
    @engine.invoices.invoices.count
  end

  def invoice_status(status)
    count = 0
    @engine.invoices.invoices.each do |invoice|
      if invoice.status == status
        count += 1
      end
    end
    ((count / total_invoices_count.to_f) * 100).round(2)
  end

  def top_revenue_earners(number_merchants = 20)
    merchants_ranked_by_revenue[0..(number_merchants - 1)]
  end

  def merchants_ranked_by_revenue
    @engine.merchants.all.sort_by do |merchant|
      merchant.total_revenue
    end.reverse
  end

  def merchants_with_only_one_item
    @engine.merchants.all.select do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end
  end

  def total_revenue_by_date(date)
    invoices = invoices_on_date(date)
    invoices.reduce(0) do |total, invoice|
      total += invoice.total
    end
  end

  def invoices_on_date(date)
    @engine.invoices.all.find_all do |invoice|
      invoice.created_at.strftime('%F') == date.strftime('%F')
    end
  end

  def merchants_with_pending_invoices
    pending = @engine.invoices.all.select do |invoice|
      !invoice.is_paid_in_full?
    end
    pending.map do |invoice|
      @engine.merchants.find_by_id(invoice.merchant_id)
    end.uniq
  end

  def most_sold_item_for_merchant(merchant_id)
    invoice_items = find_paid_invoice_items_for_merchant(merchant_id)
    item_ids = total_quantity_sold_per_item(invoice_items)
    item_id_of_max = find_item_id_of_max_value(item_ids)
    max_quantity = item_ids[item_id_of_max]
    item_ids_with_max = find_item_ids_with_max_value(item_ids, max_quantity)
    map_items_to_item_ids(item_ids_with_max)
  end

  def find_paid_invoice_items_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    invoices = paid_invoices(merchant.invoices)
    find_all_invoice_items_for_invoices(invoices)
  end

  def paid_invoices(invoices)
    invoices.find_all { |invoice| invoice.is_paid_in_full? }
  end

  def find_all_invoice_items_for_invoices(invoices)
    invoices.map do |invoice|
      @engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def total_quantity_sold_per_item(invoice_items)
    invoice_items.reduce(Hash.new(0)) do |item_ids, invoice_item|
      item_ids[invoice_item.item_id] += invoice_item.quantity
      item_ids
    end
  end

  def find_item_id_of_max_value(item_ids)
    item_ids.keys.max_by { |item_id| item_ids[item_id] }
  end

  def find_item_ids_with_max_value(item_ids, max)
    item_ids.find_all { |item_id| item_id[1] == max }
  end

  def map_items_to_item_ids(item_ids)
    item_ids.map { |item_id| @engine.items.find_by_id(item_id[0]) }
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = find_paid_invoice_items_for_merchant(merchant_id)
    item_ids = total_revenue_per_item(invoice_items)
    item_id_of_max = find_item_id_of_max_value(item_ids)
    @engine.items.find_by_id(item_id_of_max)
  end

  def total_revenue_per_item(invoice_items)
    invoice_items.reduce(Hash.new(0)) do |item_ids, invoice_item|
      item_revenue = invoice_item.quantity * invoice_item.unit_price
      item_ids[invoice_item.item_id] = item_revenue
      item_ids
    end
  end

end
