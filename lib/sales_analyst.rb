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
    Math.sqrt(
      merchants.reduce(0) do |sum, merchant|
        sum + (merchant.items.count - average_items_per_merchant)**2
      end / (merchants.count - 1)
    ).round(2)
  end

  def one_standard_deviation_above_average
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    high_item_count = one_standard_deviation_above_average
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

  def average_price_per_merchant_standard_deviation
    all_merchant_average = average_average_price_per_merchant
    Math.sqrt(
      items.reduce(0) do |sum, item|
        sum + (item.unit_price - all_merchant_average)**2
      end / (items.count - 1)
    ).round(2)
  end

  def two_standard_deviations_above_average_price
    two_standard_deviations = average_price_per_merchant_standard_deviation * 2
    return average_average_price_per_merchant + two_standard_deviations
  end

  def golden_items
    golden_price_floor = two_standard_deviations_above_average_price
    items.find_all do |item|
      item.unit_price > golden_price_floor
    end
  end

#if a merchant does not have any invoices, it will bring down the average. Do we want that or should we remove those merchants with no invoices?
  def average_invoices_per_merchant
    sum_invoices = merchants.reduce(0) do |sum, merchant|
      sum + merchant.invoices.count
    end
    (sum_invoices.to_f / merchants.count).round(1)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(
      merchants.reduce(0) do |sum, merchant|
      sum + (merchant.invoices.count - average_invoices_per_merchant)**2
    end / (merchants.count - 1)
  ).round(1)
  end

  def two_standard_deviations_above_average_invoices
    two_standard_deviations = average_invoices_per_merchant_standard_deviation * 2
    return (average_invoices_per_merchant + two_standard_deviations).round(1)
  end

  def top_merchants_by_invoice_count
    high_invoice_count = two_standard_deviations_above_average_invoices
    merchants.find_all do |merchant|
      merchant.invoices.count > high_invoice_count
    end
  end

  def two_standard_deviations_below_average_invoices
    two_standard_deviations = average_invoices_per_merchant_standard_deviation * 2
    return (average_invoices_per_merchant - two_standard_deviations).round(1)
  end

  def bottom_merchants_by_invoice_count
    low_invoice_count = two_standard_deviations_below_average_invoices
    merchants.find_all do |merchant|
      merchant.invoices.count < low_invoice_count
    end
  end

  def average_invoices_created_per_weekday
    (@sales_engine.invoices.all.count / 7.00).round(2)
  end

  def average_invoices_created_per_weekday_standard_deviation
    Math.sqrt(
      @sales_engine.invoices.invoices_created_each_weekday.reduce(0) do |sum, element|
      sum + (element[1] - average_invoices_created_per_weekday)**2
    end / (7 - 1)
  ).round(2)
  end

  def one_standard_deviation_above_average_invoices_created_per_weekday
    return (average_invoices_created_per_weekday + average_invoices_created_per_weekday_standard_deviation).round(2)
  end

  def top_days_by_invoice_count
    high_invoice_count = one_standard_deviation_above_average_invoices_created_per_weekday
    @sales_engine.invoices.invoices_created_each_weekday.find_all do |element|
      element[1] > high_invoice_count
    end.flatten[0].split
  end

  def invoice_status(status)
    number_of_invoices_with_status = @sales_engine.invoices.find_all_by_status(status.to_s).count
    ((number_of_invoices_with_status / @sales_engine.invoices.all.count.to_f) * 100).round(1)
  end
end
