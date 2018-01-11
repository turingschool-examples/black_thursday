require 'bigdecimal'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_item_count = average_items_per_merchant
    Math.sqrt(
      merchants.reduce(0) do |sum, merchant|
        sum + (merchant.items.count - average_item_count)**2
      end / (merchants.count - 1)
    ).round(2)
  end

  def one_stdev_above_average
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    high_item_count = one_stdev_above_average
    merchants.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.find_merchant_by_merchant_id(merchant_id)
    return merchant.average_item_price
  end

  def average_average_price_per_merchant
    sum_averages = merchants.reduce(0) do |total, merchant|
      total + merchant.average_item_price
    end
    return (sum_averages / merchants.count).round(2)
  end

  def average_price_per_merchant_stdev
    all_merchant_average = average_average_price_per_merchant
    Math.sqrt(
      items.reduce(0) do |sum, item|
        sum + (item.unit_price - all_merchant_average)**2
      end / (items.count - 1)
    ).round(2)
  end

  def two_stdevs_above_average_price
    two_stdevs = average_price_per_merchant_stdev * 2
    return average_average_price_per_merchant + two_stdevs
  end

  def golden_items
    golden_price_floor = two_stdevs_above_average_price
    items.find_all do |item|
      item.unit_price > golden_price_floor
    end
  end

  def average_invoices_per_merchant
    sum_invoices = merchants.sum do |merchant|
      merchant.invoices.count
    end
    return (sum_invoices.to_f / merchants.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    Math.sqrt(
      merchants.sum do |merchant|
        (merchant.invoices.count - average)**2
      end / (merchants.count - 1)
    ).round(2)
  end

  def two_stdevs_above_average_invoices
    two_stdevs = average_invoices_per_merchant_standard_deviation * 2
    return (average_invoices_per_merchant + two_stdevs).round(1)
  end

  def top_merchants_by_invoice_count
    high_invoice_count = two_stdevs_above_average_invoices
    merchants.find_all do |merchant|
      merchant.invoices.count > high_invoice_count
    end
  end

  def two_stdevs_below_average_invoices
    two_stdevs = average_invoices_per_merchant_standard_deviation * 2
    return (average_invoices_per_merchant - two_stdevs).round(1)
  end

  def bottom_merchants_by_invoice_count
    low_invoice_count = two_stdevs_below_average_invoices
    merchants.find_all do |merchant|
      merchant.invoices.count < low_invoice_count
    end
  end

  def average_invoices_per_weekday
    (@sales_engine.invoices.all.count / 7.00).round(2)
  end

  def average_invoices_per_weekday_stdev
    average = average_invoices_per_weekday
    Math.sqrt(
      @sales_engine.invoices.invoices_each_weekday.values.sum do |invoices|
        (invoices.count - average)**2
      end / (7 - 1)
    ).round(2)
  end

  def one_stdev_above_average_invoices_per_weekday
    (average_invoices_per_weekday + average_invoices_per_weekday_stdev).round(2)
  end

  def top_days_by_invoice_count
    high_invoice_count = one_stdev_above_average_invoices_per_weekday
    @sales_engine.invoices.invoices_each_weekday.keep_if do |weekday, invoices|
      invoices.count > high_invoice_count
    end.keys
  end

  def invoice_status(status)
    invoices = @sales_engine.invoices
    invoice_status_count = invoices.find_all_by_status(status).count
    ((invoice_status_count / invoices.all.count.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    invoices = @sales_engine.invoices.find_all_by_date(date)
    invoices.sum do |invoice|
      invoice.total
    end
  end

  def top_revenue_earners(number_of_merchants = 20)
    merchants.max_by(number_of_merchants) do |merchant|
      merchant.revenue
    end
  end

  def merchants_with_pending_invoices
    merchants.find_all do |merchant|
      merchant.pending_invoices?
    end
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(merchants.count)
  end

  def merchants_with_only_one_item
    merchants.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.month_registered == month.downcase
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    return merchant.revenue
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    item_ids = merchant.most_sold_item_ids
    item_ids.map do |item_id|
      @sales_engine.find_item_by_item_id(item_id)
    end
  end

  def best_item_for_merchant(merchant_id)
    merchant = @sales_engine.merchants.find_by_id(merchant_id)
    item_id = merchant.best_item_id
    return @sales_engine.find_item_by_item_id(item_id)
  end
end
