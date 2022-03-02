require "merchant_repo"
require "item_repo"
require "invoice_repo"
require "customer_repo"
require "transaction_repo"
require "invoice_item_repo"
require "bigdecimal"
require "pry"

class SalesAnalyst
  attr_reader :itemrepository,
    :merchantrepository,
    :invoicerepository,
    :customerrepository,
    :transactionrepository,
    :invoiceitemrepository,
    :items,
    :merchants,
    :invoices,
    :customers,
    :transactions,
    :invoiceitems

  def initialize(items_repo,
    merchants_repo,
    invoices_repo,
    customers_repo,
    transactions_repo,
    invoice_items_repo)
    @itemrepository = items_repo
    @merchantrepository = merchants_repo
    @invoicerepository = invoices_repo
    @customerrepository = customers_repo
    @transactionrepository = transactions_repo
    @invoiceitemrepository = invoice_items_repo
    @items = @itemrepository.all
    @merchants = @merchantrepository.all
    @invoices = @invoicerepository.all
    @customers = @customerrepository.all
    @transactions = @transactionrepository.all
    @invoiceitems = @invoiceitemrepository.all
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count.to_f).round(2)
  end

  def total_items_per_merchant
    results = []
    merchants.each do |merchant|
      item_count = items.count do |item|
        item.item_attributes[:merchant_id] == merchant.merchant_attributes[:id]
      end
      results << item_count
    end
    results
  end

  def standard_deviation(mean, variance)
    result = variance.sum { |object| (object - mean)**2 }
    Math.sqrt(result.to_f / (variance.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(average_items_per_merchant, total_items_per_merchant)
  end
  
  def merchants_with_high_item_count
    stdev = average_items_per_merchant_standard_deviation
    high_items = []
    average = average_items_per_merchant
    total_items_per_merchant.each_with_index do |total, index|
      if total > stdev + average
        high_items << merchants[index]
      end
    end
    return high_items
  end

  def average_item_price_for_merchant(merchant_id)
    items = itemrepository.find_all_by_merchant_id(merchant_id)
    unit_price_total = 0
    if items.count > 0
      items.each do |item|
        unit_price_total += item.unit_price_to_dollars
      end
      unit_price_total = (unit_price_total / items.count).round(2)
    end
    return unit_price_total
      
  end

  def average_average_price_per_merchant
    average_prices = []
    merchants.each do |merchant|
      average_prices << average_item_price_for_merchant(merchant.merchant_attributes[:id])
    end
    unfixed_average = (average_prices.sum / average_prices.length).round(3)
    cut_average = unfixed_average.to_s.split('')
    cut_average.delete_at(-1)
    cut_average.join('').to_f
  end

  def golden_items
    golden_items = []
    total_prices = []
    price_average = 0
    items.each do |item|
      price_average << item.item_attributes[:unit_price]
      total_prices << item.item_attributes[:unit_price]
    end
    price_average = (price_average / items.count).round(2)
    stdev = standard_deviation(price_average, total_prices)
    items.find_all do |item| 
      item.item_attributes[:unit_price] > price_average + (stdev * 2)
    end
  end

  def average_invoices_per_merchant
    (invoices.count.to_f / merchants.count.to_f).round(2)
  end

  def total_invoices_per_merchant
    results = []
    merchants.each do |merchant|
      invoice_count = invoices.count do |invoice|
        invoice.invoice_attributes[:merchant_id] == merchant.merchant_attributes[:id]
      end
      results << invoice_count
    end
    results
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(average_invoices_per_merchant, total_invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    stdev = average_invoices_per_merchant_standard_deviation
    total_invoices = total_invoices_per_merchant
    average = average_invoices_per_merchant
    top_merchants = []
    total_invoices.each_with_index do |total, index|
      if total > (average + (stdev * 2)).to_i
        top_merchants << merchants[index]
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    stdev = average_invoices_per_merchant_standard_deviation
    total_invoices = total_invoices_per_merchant
    average = average_invoices_per_merchant
    bottom_merchants = []
    total_invoices.each_with_index do |total, index|
      if total < (average - (stdev * 2)).to_i
        bottom_merchants << merchants[index]
      end
    end
    bottom_merchants
  end

  def average_invoices_per_day
    (invoices.count.to_f / 7).round(2)
  end

  def total_invoices_per_day
    results = []
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    days.each_with_index do |day, index|
      invoice_count = invoices.count do |invoice|
        time = Time.parse(invoice.invoice_attributes[:created_at]).wday
        time == index
      end
      results << invoice_count
    end
    results
  end

  def average_invoices_per_day_standard_deviation
    standard_deviation(average_invoices_per_day, total_invoices_per_day)
  end

  def top_days_by_invoice_count
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    totals = total_invoices_per_day
    average = average_invoices_per_day
    stdev = average_invoices_per_day_standard_deviation
    top_days = []
    totals.each_with_index do |day, index|
      if day > (average + stdev).to_i
        top_days << days[index]
      end
    end
    top_days
  end

  def invoice_status(status)
    matches = invoices.count do |invoice|
      invoice.invoice_attributes[:status] == status
    end
    (matches.to_f/invoices.count.to_f * 100).round(2)
  end
      
end
