require 'bigdecimal'
require 'pry'

# class for analytics on merchants and item prices
class SalesAnalyst
  attr_reader :sales_engine
  def initialize(se)
    @sales_engine    = se
    @std_dev_price   = average_items_price_standard_deviation
    @std_dev_invoice = average_invoices_per_merchant_standard_deviation
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def invoices
    @sales_engine.invoices.all
  end

  def customers
    @sales_engine.customers
  end

  def invoice_count
    merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def average(numerator, denominator)
    (BigDecimal(numerator, 4) / BigDecimal(denominator, 4)).round(2)
  end

  def standard_deviation(data, average)
    result = data.map do |item|
      (item - average)**2
    end.reduce(:+) / (data.length - 1)
    Math.sqrt(result)
  end

  def average_items_per_merchant
    average(items.length, merchants.length).to_f
  end

  def average_items_per_merchant_standard_deviation
    total_items = merchants.map { |merchant| merchant.items.length }
    standard_deviation(total_items, average_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    merchants.collect do |merchant|
      difference = (merchant.items.length - average_items_per_merchant)
      merchant if difference > average_items_per_merchant_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    return 0 if find_items_with_merchant_id(id).length.zero?
    items = @sales_engine.pass_id_to_item_repo(id)
    prices = items.map(&:unit_price)
    average(prices.reduce(:+), items.length)
  end

  def find_items_with_merchant_id(id)
    @sales_engine.merchants.find_by_id(id).items
  end

  def average_average_price_per_merchant
    result = merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    average(result, merchants.length)
  end

  def all_item_prices
    items.map(&:unit_price)
  end

  def average_items_price_standard_deviation
    standard_deviation(all_item_prices, average_average_price_per_merchant)
  end

  def golden_items
    @sales_engine.items.all.collect do |item|
      difference = (item.unit_price - average_average_price_per_merchant).to_f
      item if difference > @std_dev_price * 2
    end.compact
  end

  def average_invoices_per_merchant
    @invoice_average = average(invoices.length, merchants.length).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    total_invoices = merchants.map { |merchant| merchant.invoices.length }
    @invoice_deviation = standard_deviation(total_invoices, average_invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    average_invoices_per_merchant_standard_deviation
    merchants.each do |merchant|
      if merchant.invoices.count > ((@invoice_deviation * 2) + @invoice_average)
        top_merchants << merchant
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    average_invoices_per_merchant_standard_deviation
    merchants.each do |merchant|
      if merchant.invoices.count < (@invoice_average - (@invoice_deviation * 2))
        bottom_merchants << merchant
      end
    end
    bottom_merchants
  end

  def finding_number_of_invoices_per_day
    invoices_per_day = Hash.new(0)
    invoice_dates.each do |day|
      invoices_per_day[day] += 1
    end
    invoices_per_day
  end

  def invoice_dates
    invoices.map do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def average_invoice_per_day
    invoice_count.reduce(:+) / 7.0
  end

  def invoice_day_deviation
    days = finding_number_of_invoices_per_day
    total = days.map do |day, count|
      (count - average_invoice_per_day)**2
    end
    Math.sqrt(total.reduce(:+) / (total.length - 1)).round(2)
  end

  def top_days_by_invoice_count
    average = average_invoice_per_day
    deviation = invoice_day_deviation
    days = finding_number_of_invoices_per_day
    days.select do |day, number|
      day if number > (deviation + average)
    end.keys
  end

  def invoice_status(status)
    total = 0
    invoices.each do |invoice|
      total += 1 if invoice.status == status
    end
    ((total.to_f / invoices.count.to_f) * 100).round(2)
  end

  def finding_invoice_items(id)
    new_stuff = Hash.new
    customer = customers.find_by_id(id)
    high = customer.invoices.map do |invoice|
      new_stuff[invoice] = invoice.invoice_items.map do |invoice_item|
        invoice_item.quantity.to_i
      end.sum
    end
    new_stuff
  end

  def top_merchant_for_customer(id)
    high = finding_invoice_items(id).max_by do|invoice, orders|
      orders
    end
    high[0].merchant
  end

end
