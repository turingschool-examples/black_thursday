require 'bigdecimal'
require './lib/item_repository'

class SalesAnalyst
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository

  def initialize(item_repository, merchant_repository, invoice_repository, invoice_item_repository, customer_repository, transaction_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
    @invoice_item_repository = invoice_item_repository
    @customer_repository = customer_repository
    @transaction_repository  = transaction_repository
  end

  def average_items_per_merchant
   (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = items_per_merchant.values.sum(0.0) {|item| (item - mean) ** 2}
    variance = (sum / (items_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg_items = average_items_per_merchant
    @merchant_repository.all.find_all do |merchant|
      @item_repository.find_all_by_merchant_id(merchant.id).count > (avg_items +  std_dev)
    end
  end

  def items_per_merchant
    merchant_items = Hash.new
    item_count = 0
    @merchant_repository.all.each do |merchant|
      item_count = @item_repository.find_all_by_merchant_id(merchant.id).size
      merchant_items[merchant.id] = item_count
    end
    merchant_items
  end

  def average_item_price_for_merchant(id)
    merchant_items = @item_repository.find_all_by_merchant_id(id)
    price_sum = merchant_items.sum(0.0) {|item| item.unit_price}
    (price_sum / merchant_items.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_averages =[]
    @merchant_repository.all.each do |merchant|
      merchant_averages << average_item_price_for_merchant(merchant.id)
    end
    (merchant_averages.sum(0.0) / merchant_averages.count).round(2)
  end

  def average_price_per_merchant_standard_deviation
    mean = average_average_price_per_merchant
    sum = price_averages_per_merchant.values.sum(0.0) {|price| (price - mean) ** 2}
    variance = (sum / (price_averages_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def price_averages_per_merchant
    merchant_price_averages = Hash.new
    @merchant_repository.all.each do |merchant|
      merchant_price_averages[merchant.id] = average_item_price_for_merchant(merchant.id)
    end
    merchant_price_averages
  end

  def golden_items
    avg_avg_price = average_average_price_per_merchant
    std_dev = average_price_per_merchant_standard_deviation
    @item_repository.all.find_all do |item|
      item.unit_price > (avg_avg_price + (std_dev * 2))
    end
  end

  def average_invoices_per_merchant
    invoices = @invoice_repository.all.count.to_f
    merchants = @merchant_repository.all.count.to_f
    (invoices / merchants).round(2)
  end

  def invoices_per_merchant
    invoice_items = Hash.new
    invoice_count = 0
    @merchant_repository.all.each do |merchant|
      invoice_count = @invoice_repository.find_all_by_merchant_id(merchant.id).size
      invoice_items[merchant.id] = invoice_count
    end
    invoice_items
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = invoices_per_merchant.values.sum(0.0) {|item| (item - mean) ** 2}
    variance = (sum / (invoices_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    avg_invoices = average_invoices_per_merchant
    std_dev_2 = average_invoices_per_merchant_standard_deviation * 2
    invoice_items = invoices_per_merchant.find_all {|count| count[1] > (avg_invoices + std_dev_2)}
    invoice_items.each do | merchant_id |
      top_merchants << @merchant_repository.find_by_id(merchant_id[0])
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    avg_invoices = average_invoices_per_merchant
    std_dev_2 = average_invoices_per_merchant_standard_deviation * 2
    invoice_items = invoices_per_merchant.find_all {|count| count[1] < (avg_invoices + std_dev_2)}
    invoice_items.each do | merchant_id |
      bottom_merchants << @merchant_repository.find_by_id(merchant_id[0])
    end
    bottom_merchants
  end

  def invoices_by_weekday
    inv_count = {"Sunday" => 0, "Monday" => 0, "Tuesday" => 0, "Wednesday" => 0, "Thursday" => 0, "Friday" => 0, "Saturday" => 0 }
    @invoice_repository.all.each do |invoice|
      inv_count[invoice.created_at.strftime('%A')] += 1
    end
    inv_count
  end

  def invoice_per_day_of_week_standard_deviation
    mean = avg_invoices_per_day_of_week
    sum = invoices_by_weekday.values.sum(0.0) {|day| (day - mean) ** 2}
    variance = (sum / (invoices_by_weekday.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def avg_invoices_per_day_of_week
    (@invoice_repository.all.count / 7.0).round(2)
  end

  def top_days_by_invoice_count
    inv_count = invoices_by_weekday
    avg_invoices = avg_invoices_per_day_of_week
    std_dev = invoice_per_day_of_week_standard_deviation
    best_days = []
    inv_count.each do |day, count|
      if count > (avg_invoices + std_dev)
        best_days << day
      end
    end
    best_days
  end

  def invoice_status(status)
    status_count = @invoice_repository.find_all_by_status(status)
    ((status_count.size.to_f / @invoice_repository.all.size.to_f)* 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transaction_repository.find_all_by_invoice_id(invoice_id)
    status = []
    transactions.map  { |t| status << t.result }
    status.include?('success')
  end
  
  def invoice_total(id)
    inv_items = @invoice_item_repository.find_all_by_invoice_id(id)
    total = 0
    inv_items.map { |item| total += item.quantity * item.unit_price }
    total.to_f
  end
end
