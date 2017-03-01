require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'functions'

class SalesAnalyst
  include Functions
  attr_reader :se,
              :average_items_merchant,
              :average_price_item,
              :all_merchants,
              :all_items

  def initialize(sales_engine)
    @se                 = sales_engine
    @all_merchants      = se.merchants.all
    @all_items          = se.items.all
    @average_price_item = average_item_price
  end

  def average_items_per_merchant
    ((all_items.count.to_f) / (se.merchants.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    totals = total_items_each_merchant
    numerator = calculate_numerator(totals)
    denominator = (se.merchants.all.count - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end

  def total_items_each_merchant
    all_merchants.map { |merchant| merchant.items.count }
  end

  def calculate_numerator(totals)
    totals.reduce(0) {
      |total, merchant_total| total += (
        (merchant_total - average_items_per_merchant) ** 2
      )
    }
  end

  def merchants_with_high_item_count
    benchmark = (
      average_items_per_merchant + average_items_per_merchant_standard_deviation
      )
    all_merchants.map {
      |merchant| merchant if merchant.items.count > benchmark
    }.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = se.items.find_all_by_merchant_id(merchant_id)
    sum_item_prices = merchant_items.reduce(0) {
      |total, item| total += item.unit_price
    }
    (sum_item_prices / merchant_items.count).round(2)
  end

  def average_average_price_per_merchant
    sum_all_averages = all_merchants.reduce(0) {
      |total, merchant| total += average_item_price_for_merchant(merchant.id)
    }
    (sum_all_averages / se.merchants.all.count).round(2)
  end

  def average_item_price
    total_item_price = all_items.reduce(0) {
      |total, item| total += item.unit_price
    }
    total_item_price / all_items.count
  end

  def item_price_standard_deviation
    Math.sqrt(golden_items_numerator / golden_items_denominator).round(2)
  end

  def golden_items_numerator
    all_items.reduce(0) {
      |total, item| total += ((item.unit_price - average_price_item) ** 2)
    }
  end

  def golden_items_denominator
    all_items.count - 1
  end

  def golden_items
    benchmark = item_price_standard_deviation * 2
    all_items.map { |item| item if item.unit_price > benchmark }.compact
  end

  def average_invoices_per_merchant
    find_average(total_invoices_of_each_merchant).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(
      total_invoices_of_each_merchant,
      average_invoices_per_merchant,
      se.merchants.all.length
    )
  end


  def total_invoices_of_each_merchant
    se.merchants.all.map { |merchant| validate_number(merchant.invoices) }
  end

  def top_merchants_by_invoice_count
    find_high_invoice_count(
    above_standard_deviation(
      average_invoices_per_merchant,
      average_invoices_per_merchant_standard_deviation,
      2
      )
    )
  end

  def find_high_invoice_count(above)
    all_merchants.find_all { |merchant| merchant.invoices.length > above }
  end

  def bottom_merchants_by_invoice_count
    find_low_invoice_count(
    below_standard_deviation(
      average_invoices_per_merchant,
      average_invoices_per_merchant_standard_deviation,
      2
      )
    )
  end

  def find_low_invoice_count(above)
    all_merchants.find_all { |merchant| merchant.invoices.length < above }
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
      above_standard_deviation(
        average_invoices_created_per_day,
        average_invoices_per_day_standard_deviation
      )
    )
  end

  def find_top_days_by_invoice_count(average)
    days = ["Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday"]
    split_invoices_by_creation_date.map.with_index {
      |invoices_on_day, i| days[i] if invoices_on_day > average
    }.compact
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(
      split_invoices_by_creation_date, average_invoices_created_per_day, 7
      )
  end

  def average_invoices_created_per_day
    find_average(split_invoices_by_creation_date).round(2)
  end

  def total_revenue_by_date(date)
    inv = se.invoices.find_all_by_date(date)
    inv.reduce(0) { |total, invoice|
      total += se.invoice_items.find_all_by_invoice_id(invoice.id).reduce(0) {
        |t, ii| t += (ii.quantity * ii.unit_price)
      }
    }
  end

  def merchant_totals
    all_merchants.map {
      |merchant| merchant.invoices.reduce(0) {
        |total, invoice| total += invoice.total
        }
      }
  end

  def top_revenue_earners(amount = 20)
    Hash[all_merchants.zip(merchant_totals)].sort_by {
      |key, value| -value }[0...amount].map {
        |array| array[0]
    }
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(all_merchants.count)
  end

  def merchants_with_pending_invoices
    se.invoices.all.map {
      |invoice| invoice.merchant if invoice.pending?
    }.compact.uniq
  end

  def merchants_with_only_one_item
    all_merchants.map {
      |merchant| merchant if merchant.items.count == 1
    }.compact.uniq
  end

end