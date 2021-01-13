require_relative './sales_engine'
require_relative './item_repo'
require_relative './invoice_repo'
require_relative './merchant_repo'
require_relative './transaction_repo'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def average_items_per_merchant
    (all_merchant_item_count.values.sum.to_f / all_merchant_item_count.values.size).round(2)
  end

  def all_merchant_item_count
    @sales_engine.merchants.all.map do |merchant|
      @sales_engine.merchant_items(merchant.id).length
    end
  end

  def average_items_per_merchant_standard_deviation(merchant_items)
    mean = average_items_per_merchant
    variance = merchant_items.inject(0) do |variance, item_count|
      variance += (item_count - mean) ** 2
    end
    Math.sqrt(variance / (merchant_items.size - 1)).round(2)
    (all_merchant_item_count.values.sum.to_f / all_merchant_item_count.size).round(2)
  end

  def all_merchant_item_count
    merchant_items = Hash.new(0)
    @sales_engine.merchants.all.each do |merchant|
      merchant_items[merchant] = @sales_engine.merchant_items(merchant.id).length
    end
    merchant_items
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    variance = all_merchant_item_count.values.inject(0) do |variance, item_count|
      variance += (item_count - mean) ** 2
    end
    Math.sqrt(variance / (all_merchant_item_count.values.size - 1)).round(2)
  end

  def merchants_with_high_item_count
    merchants = []
    all_merchant_item_count.each do |merchant, item_count|
      # if item_count > (average_items_per_merchant_standard_deviation(all_merchant_item_count.values)) + 3
      if item_count > 6
        merchants << merchant
      end
    end
    merchants
  end

  def average_item_price_for_merchant(merchant_id)
    prices = []
    @sales_engine.merchant_items(merchant_id).each do |item|
      prices << item.unit_price_to_dollars
    end
    BigDecimal((prices.sum / prices.size), 4)
  end

  def average_average_price_per_merchant
    all_averages = []
    @sales_engine.merchants.all.each do |merchant|
      all_averages << average_item_price_for_merchant(merchant.id)
    end
    BigDecimal(all_averages.sum / all_averages.size).truncate(2)
  end

  def average_invoices_per_merchant
    ((@sales_engine.numerator_invoices_per_merchant.to_f) / (@sales_engine.all_merchant_invoices.length)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    data_set = @sales_engine.all_merchant_invoices
    standard_deviation(mean, data_set)
  end

  def standard_deviation (mean, data_set)
    numerator = data_set.sum do |data_point|
      (data_point - mean) ** 2
    end
    (Math.sqrt(numerator / (data_set.length - 1))).round(2)
  end

  def top_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    stan_dev = average_invoices_per_merchant_standard_deviation
    @sales_engine.merchants.all.select do |merchant|
      @sales_engine.merchant_invoices(merchant.id).length > (mean + ( 2 * stan_dev.to_f))
    end
  end

  def bottom_merchants_by_invoice_count
    mean = average_invoices_per_merchant
    stan_dev = average_invoices_per_merchant_standard_deviation
    @sales_engine.merchants.all.select do |merchant|
      @sales_engine.merchant_invoices(merchant.id).length.to_f < (mean - ( 2 * stan_dev.to_f))
    end
  end

  def average_invoices_per_day
    numerator = 0
    @sales_engine.invoices.invoices_per_weekday.values.each do |weekday|
      numerator = numerator + weekday.count
    end
    ((numerator.to_f / @sales_engine.invoices.invoices_per_weekday.keys.count.to_f)).round(2)
  end

  def average_invoices_per_day_standard_deviation
    mean = average_invoices_per_day
    data_set = @sales_engine.invoices_per_day_count.values
    standard_deviation(mean, data_set)
  end

  def top_days_by_invoice_count
    answer = []
    @sales_engine.invoices_per_day_count.each do |day, invoice_count|
      if invoice_count > (average_invoices_per_day + average_invoices_per_day_standard_deviation)
        answer << day.to_s.capitalize
      end
    end
    answer
  end

  def invoice_status(status)
    (100 * (@sales_engine.invoice_status_count(status).to_f / @sales_engine.invoices.all.length.to_f)).round(2)
  end

  def merchants_with_pending_invoices
    @sales_engine.merchants_with_pending_invoices
  end

  def golden_items
    prices = []
    @sales_engine.items.all.each do |item|
      prices << item.unit_price
    end
    avg = average_average_price_per_merchant
    new_prices = []
    prices.each do |price|
      new_prices << (price - avg) ** 2
    end
    standard_deviation = Math.sqrt(new_prices.reduce(:+) / (new_prices.count)).round(2)
    standard_deviation_by_two = avg + (2 * standard_deviation)
    items = @sales_engine.items.all
    golden_items = []
    items.each do |item|
      golden_items << item if item.unit_price > standard_deviation_by_two
    end
     golden_items
  end

  def merchants_with_only_one_item
    @sales_engine.merchants.all.find_all do |merchant|
      @sales_engine.merchant_items(merchant.id).length == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    month_name_to_num = Date::MONTHNAMES.index(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.month == month_name_to_num
    end
  end

  def invoice_paid_in_full?(invoice_id)
    transacts = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    success = transacts.map do |transact|
      true if transact.result == :success
     end
    if success.include?(true) == true
      true
    else
      false
    end
  end

  def invoice_total(invoice_id)
    all_items = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    all_prices = all_items.map do |item|
      (item.unit_price * item.quantity)
    end
    all_prices.sum
  end

  def total_revenue_by_date(day)
    @sales_engine.total_revenue_by_date(day)
  end
end
