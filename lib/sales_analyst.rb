require_relative './analysis_math'

class SalesAnalyst
  include AnalysisMath
  attr_reader :sales_engine

  DAY_NUM_TO_WORD = {
    0 => "Monday",
    1 => "Tuesday",
    2 => "Wednesday",
    3 => "Thursday",
    4 => "Friday",
    5 => "Saturday",
    6 => "Sunday"
  }

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_price_for_merchant(id)
    merchant_items = @sales_engine.find_all_items_by_merchant_id(id)
    prices = get_item_prices(merchant_items)
    mean(prices).round(2)
  end

  def average_average_price_per_merchant
    all_merchants = @sales_engine.all_merchants
    total_average_price = all_merchants.reduce(0) do |result, merchant|
      result += average_item_price_for_merchant(merchant.id)
      result
    end
    average_price = (total_average_price / all_merchants.count).floor(2)
  end

  def price_standard_deviation_for_merchant(id)
    merchant_items = @sales_engine.find_all_items_by_merchant_id(id)
    prices = get_item_prices(merchant_items)
    standard_deviation(prices)
  end

  def price_standard_deviation
    all_prices = get_item_prices(@sales_engine.all_items)
    standard_deviation(all_prices).round(2)
  end

  def golden_items(num_of_std = 2)
    cutoff =
      average_average_price_per_merchant + num_of_std*price_standard_deviation
    @sales_engine.all_items.find_all do |item|
      item.unit_price > cutoff
    end
  end

  def average_items_per_merchant
    merchant_item_counts = get_merchant_item_counts(@sales_engine.all_merchants)
    mean(merchant_item_counts).round(2).to_f
  end

  def average_items_per_merchant_standard_deviation
    merchant_item_counts = get_merchant_item_counts(@sales_engine.all_merchants)
    standard_deviation(merchant_item_counts)
  end

  def merchants_with_high_item_count
    cutoff =
      average_items_per_merchant + average_items_per_merchant_standard_deviation
    @sales_engine.all_merchants.find_all do |merchant|
      merchant.items.count > cutoff
    end
  end

  def average_invoices_per_merchant
    invoice_counts = get_merchant_invoice_counts(@sales_engine.all_merchants)
    mean(invoice_counts).to_f.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_counts = get_merchant_invoice_counts(@sales_engine.all_merchants)
    standard_deviation(invoice_counts).round(2)
  end

  def top_merchants_by_invoice_count(num_of_std = 2)
    cutoff = average_invoices_per_merchant +
     num_of_std * average_invoices_per_merchant_standard_deviation
    @sales_engine.all_merchants.find_all do |merchant|
      merchant.invoices.count > cutoff
    end
  end

  def bottom_merchants_by_invoice_count(num_of_std = 2)
    cutoff = average_invoices_per_merchant -
     num_of_std * average_invoices_per_merchant_standard_deviation
    @sales_engine.all_merchants.find_all do |merchant|
      merchant.invoices.count < cutoff
    end
  end

  def invoice_status(status)
    sought_invoices = @sales_engine.invoice_repo.find_all_by_status(status)
    fraction = sought_invoices.count.to_f / @sales_engine.all_invoices.count
    (fraction * 100).round(2)
  end

  def average_invoices_per_day
    invoices_per_day = get_day_invoice_counts(@sales_engine.all_invoices)
    mean(invoices_per_day).round(2)
  end

  def average_invoices_per_day_std
    invoices_per_day = get_day_invoice_counts(@sales_engine.all_invoices)
    standard_deviation(invoices_per_day)
  end

  def top_days_by_invoice_count
    cutoff = average_invoices_per_day + average_invoices_per_day_std
    all_invoices = @sales_engine.all_invoices
    top_days = get_day_invoice_counts(all_invoices).map.with_index do |day_count, day|
      DAY_NUM_TO_WORD[day] if day_count > cutoff
    end
    top_days.delete(nil)
    top_days
  end

  def merchants_with_pending_invoices
    @sales_engine.all_merchants.find_all do |merchant|
      merchant.invoices.any? do |invoice|
        !invoice.is_paid_in_full?
      end
    end
  end

  def merchants_with_only_one_item
    @sales_engine.all_merchants.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def total_revenue_by_date(date)
    invoices_to_be_consider = @sales_engine.all_invoices.find_all do |invoice|
      invoice.created_at.strftime("%F") == date.strftime("%F") && invoice.is_paid_in_full?
    end
    invoices_to_be_consider.reduce(0) do |result, invoice|
      result += invoice.total
      result
    end
  end

  def get_item_prices(items)
    items.map do |item|
      item.unit_price_to_dollars
    end
  end

  def get_merchant_item_counts(merchants)
    merchants.map do |merchant|
      merchant.items.count
    end
  end

  def get_merchant_invoice_counts(merchants)
    merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def get_day_invoice_counts(invoices)
    group_invoices_by_day(invoices).map do |day_invoice_data|
      day_invoice_data[1].count
    end
  end

  def group_invoices_by_day(invoices)
    invoices.group_by do |invoice|
      invoice.created_at.wday
    end
  end

end
