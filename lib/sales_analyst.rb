require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'functions'


class SalesAnalyst
  include Functions
  attr_reader :se, :average_items_merchant, :average_price_item

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    ((se.items.all.count.to_f) / (se.merchants.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    totals = total_items_each_merchant
    numerator = calculate_numerator(totals)
    denominator = (se.merchants.all.count - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end

  def total_items_each_merchant
    se.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def calculate_numerator(totals)
    totals.map do |merchant_total|
      (merchant_total - average_items_per_merchant)**2
    end.reduce(:+)
  end

  def merchants_with_high_item_count
    benchmark = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_performers = []
    se.merchants.all.each do |merchant|
      if merchant.items.count > benchmark
        high_performers << merchant
      end
    end
    high_performers
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = se.items.find_all_by_merchant_id(merchant_id)
    sum_item_prices = merchant_items.map do |item|
      item.unit_price
    end.reduce(:+)
    (sum_item_prices / merchant_items.count).round(2)
  end

  def average_average_price_per_merchant
    sum_all_averages = se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
    (sum_all_averages / se.merchants.all.count).round(2)
  end

  def average_item_price
    total_item_price = se.items.all.map do |item|
      item.unit_price
    end.reduce(:+)
    total_item_price / se.items.all.count
  end

  def item_price_standard_deviation
    Math.sqrt(golden_items_numerator / golden_items_denominator).round(2)
  end

  def golden_items_numerator
    se.items.all.map do |item|
      (item.unit_price - average_price_item)**2
    end.reduce(:+)
  end

  def golden_items_denominator
    se.items.all.count - 1
  end

  def golden_items
    @average_price_item =  average_item_price
    benchmark = item_price_standard_deviation * 2
    golden_items = []
    se.items.all.each do |item|
      if item.unit_price > benchmark
        golden_items << item
      end
    end
    golden_items
  end

  def average_invoices_per_merchant
    find_average(total_invoices_of_each_merchant).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(total_invoices_of_each_merchant, average_invoices_per_merchant, se.merchants.all.length)
  end


  def total_invoices_of_each_merchant
    se.merchants.all.map do |merchant|
      validate_number(merchant.invoices)
    end
  end

  def top_merchants_by_invoice_count
    find_high_invoice_count(
    above_standard_deviation(average_invoices_per_merchant, average_invoices_per_merchant_standard_deviation, 2)
    )
  end

  def find_high_invoice_count(above)
    se.merchants.all.find_all do |merchant|
      merchant.invoices.length > above
    end
  end

  def bottom_merchants_by_invoice_count
    find_low_invoice_count(
    below_standard_deviation(average_invoices_per_merchant, average_invoices_per_merchant_standard_deviation, 2)
    )
  end

  def find_low_invoice_count(above)
    se.merchants.all.find_all do |merchant|
      merchant.invoices.length < above
    end
  end

  def invoice_status(status)
    ((number_of_invoices(status) / se.invoices.all.length.to_f) * 100).round(2)
  end

  def number_of_invoices(status)
    se.invoices.all.reduce(0) do |result, invoice|
      result += 1 if invoice.status == status
      result
    end
  end

  def top_days_by_invoice_count
    find_top_days_by_invoice_count(
    above_standard_deviation(average_invoices_created_per_day, average_invoices_per_day_standard_deviation)
    )
  end

  def find_top_days_by_invoice_count(average)
    days = ["Sunday", "Monday", "Tuesday", "Wednesday",
            "Thursday", "Friday", "Saturday"]
    split_invoices_by_creation_date.map.with_index do |invoices_on_day, i|
      days[i] if invoices_on_day > average
    end.compact
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(split_invoices_by_creation_date, average_invoices_created_per_day, 7)
  end

  def average_invoices_created_per_day
    find_average(split_invoices_by_creation_date).round(2)
  end

  def total_revenue_by_date(date)
    inv = se.invoices.find_all_by_date(date)
    inv.reduce(0) do |total, invoice|
      total += se.invoice_items.find_all_by_invoice_id(invoice.id).reduce(0) do |t, ii|
       t += (ii.quantity * ii.unit_price)
      end
    end
  end

  def merchant_totals
    se.merchants.all.map do |merchant|
      se.invoices.find_all_by_merchant_id(merchant.id).map do |invoices|
        if invoices.is_paid_in_full?
          invoices.total
        else
         invoices.each_paid
        end
      end.reduce(:+)
    end
  end

  def merchants_array
    se.merchants.all.map
  end

  def top_revenue_earners(amount)
    # require'pry';binding.pry
    Hash[merchants_array.zip(merchant_totals)].sort_by { |key, value| -value }[0...amount].map { |hash| hash[0] }
  end
end