require_relative './sales_engine'
require_relative './merchant_analytics'

class SalesAnalyst
  include MerchantAnalytics
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @days = {
            0 => "Sunday",
            1 => "Monday",
            2 => "Tuesday",
            3 => "Wednesday",
            4 => "Thursday",
            5 => "Friday",
            6 => "Saturday"
            }
  end

  def average_items_per_merchant
    merchants_total = find_number_of_merchants_for_items
    items_total = find_total_number_of_items
    (items_total.to_f / merchants_total).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    ipm = items_per_merchant
    v = variance(average, ipm)
    square_root_of_variance(v, ipm)
  end

  def group_items_by_merchant
    @sales_engine.items.all.group_by(&:merchant_id)
  end

  def find_number_of_merchants_for_items
    group_items_by_merchant.inject(0) do |count, (id, items)|
      count + 1
    end
  end

  def find_total_number_of_items
    group_items_by_merchant.inject(0) do |count, (id, items)|
      count + items.count
    end
  end

  def items_per_merchant
    group_items_by_merchant.map do |id, items|
      items.count
    end
  end

  def variance(average, array)
    variance = array.inject(0) do |count, items|
      count += (items.to_f - average) ** 2
    end
  end

  def square_root_of_variance(variance, array)
    (Math.sqrt(variance/(array.size-1))).round(2)
  end

  def items_one_standard_deviation_above
    #item quantity
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    item_amount_per_merchant.map do |id, quantity|
      @sales_engine.merchants.find_by_id(id) if quantity >= items_one_standard_deviation_above
    end.compact
  end

  def item_amount_per_merchant
    group_items_by_merchant.keys.zip(items_per_merchant)
  end

  def number_of_merchants
    @sales_engine.merchants.all.count
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    sum = items.inject(0) do |total, item|
      total + item.unit_price
    end
    (sum / items.count).round(2)
  end

  def average_average_price_per_merchant
    sum = @sales_engine.merchants.all.inject(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    (sum / number_of_merchants).round(2)
  end

  def average_item_prices_for_each_merchant
    @sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def all_item_prices_total
    @sales_engine.items.all.inject(0) do |total, item|
      total + item.unit_price
    end
  end

  def item_price_average
    (all_item_prices_total.to_f / @sales_engine.items.all.count).round(2)
  end

  def all_item_prices
    @sales_engine.items.all.map do |item|
      item.unit_price
    end
  end

  def standard_deviation_for_item_price
    v = variance(item_price_average, all_item_prices)
    square_root_of_variance(v, all_item_prices)
  end

  def item_two_standard_deviations_above
    item_price_average + (standard_deviation_for_item_price * 2)
  end

  def golden_items
    @sales_engine.items.all.each_with_object([]) do |item, collection|
      collection << item if item.unit_price >= item_two_standard_deviations_above
      collection
    end
  end


#---------------ITERATION-2-STUFF------------------------#
# sales_analyst.average_invoices_per_merchant # => 10.49
  def average_invoices_per_merchant
    merchants_total = find_number_of_merchants_for_invoices
    invoices_total = find_total_number_of_invoices
    (invoices_total.to_f / merchants_total).round(2)
  end
# sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    ipm = invoices_per_merchant
    v = variance(average, ipm)
    square_root_of_variance(v, ipm)
  end

  def group_invoices_by_merchant
    @sales_engine.invoices.all.group_by(&:merchant_id)
  end

  def find_number_of_merchants_for_invoices
    group_invoices_by_merchant.inject(0) do |count, (id, invoices)|
      count + 1
    end
  end

  def find_total_number_of_invoices
    group_invoices_by_merchant.inject(0) do |count, (id, invoices)|
      count + invoices.count
    end
  end

  def invoices_per_merchant
    group_invoices_by_merchant.map do |id, invoices|
      invoices.count
    end
  end

# Which merchants are more than two standard deviations above the mean?
# sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
  def invoices_one_standard_deviation_above
    sum = average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation
    sum.round(2)
  end

  def invoices_two_standard_deviations_above
    sum = average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation*2
    sum.round(2)
  end

  def top_merchants_by_invoice_count
    merchants = []
    group_invoices_by_merchant.find_all do |id, invoices|
      if invoices.count >= invoices_two_standard_deviations_above
        merchants << @sales_engine.merchants.find_by_id(id)
      end
    end
    merchants
  end
# sales_analyst.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
  def invoices_two_standard_deviations_below
    diff = average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation*2
    diff.round(2)
  end

  def bottom_merchants_by_invoice_count
    merchants = []
    group_invoices_by_merchant.find_all do |id, invoices|
      if invoices.count <= invoices_two_standard_deviations_below
        merchants << @sales_engine.merchants.find_by_id(id)
      end
    end
    merchants
  end

  def group_invoices_by_day_created
    @sales_engine.invoices.all.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def number_of_invoices
    @sales_engine.invoices.all.count
  end

  def average_invoices_per_day
    days_total = find_number_of_days_for_invoices
    invoices_total = find_total_number_of_invoices
    (invoices_total.to_f / days_total).round(2)
  end

  def average_invoices_per_day_standard_deviation
    average = average_invoices_per_day
    ipd = invoices_per_day
    v = variance(average, ipd)
    square_root_of_variance(v, ipd)
  end

  def find_number_of_days_for_invoices
    group_invoices_by_day_created.inject(0) do |count, (day, invoices)|
      count + 1
    end
  end

  def find_total_number_of_invoices
    group_invoices_by_day_created.inject(0) do |count, (day, invoices)|
      count + invoices.count
    end
  end

  def invoices_per_day
    group_invoices_by_day_created.map do |day, invoices|
      invoices.count
    end
  end

  def invoices_per_day_one_standard_deviation_above
    sum = average_invoices_per_day + average_invoices_per_day_standard_deviation
    sum.round(2)
  end

  def top_days_by_invoice_count
    top_days = []
    group_invoices_by_day_created.find_all do |day, invoices|
      if invoices.count >= invoices_per_day_one_standard_deviation_above
        top_days << @days[day]
      end
    end
    top_days
  end

  def invoice_status(status)
    number_of_invoices_with_status = group_invoices_by_status[status].count
    ratio = number_of_invoices_with_status / number_of_invoices.to_f
    percentage = ratio * 100
    percentage.round(2)
  end

  def group_invoices_by_status
    @sales_engine.invoices.all.group_by do |invoice|
      invoice.status
    end
  end

  def invoice_paid_in_full?(invoice_id)
    return false if @sales_engine.transactions.find_all_by_invoice_id(invoice_id) == []
    invoice = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    invoice.all? do |invoice|
      invoice.result == :success
    end
  end

  def invoice_total(invoice_id)
    return nil if @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id) == []
    invoice_items = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.inject(0) do |total, invoice_item|
      total + (invoice_item.unit_price * invoice_item.quantity)
    end
  end
end
