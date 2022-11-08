require 'csv'
require 'bigdecimal/util'
require_relative 'sales_engine'
require_relative 'item'
require_relative 'merchant'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions
  def initialize(item_repo = nil, merchant_repo = nil, invoice_repo = nil, invoice_item_repo = nil, transaction_repo = nil)
    @items = item_repo
    @merchants = merchant_repo
    @invoices = invoice_repo
    @invoice_items = invoice_item_repo
    @transactions = transaction_repo
  end

  def item_count
    items.all.count
  end

  def items_per_merchant(id)
    items.find_all_by_merchant_id(id).count
  end

  def merchant_count
    merchants.all.count
  end

  def average_items_per_merchant
    (item_count / merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
    average = average_items_per_merchant
    differences = 0
    merchants.map do |num|
      differences += (num - average)**2
    end
    Math.sqrt(differences / (merchants.count - 1).to_f).round(2)
  end

  def average_item_price_for_merchant(id)
    stock = (items.find_all_by_merchant_id(id))
    price_array = stock.map {|stock| stock.unit_price }.sum
    @average_item_price = (price_array / stock.count).round(2)
    @average_item_price
  end

  def average_average_price_per_merchant
    sellers = merchants.all
    array = []
    sellers.each do |seller|
      array << self.average_item_price_for_merchant(seller.id)
    end
    (array.sum / sellers.count).round(2)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @merchants.all.find_all { |merchant| items_per_merchant(merchant.id) > threshold }
  end

  def golden_items
    unit_price_sum = @items.all.map {|item| item.unit_price }.sum
    price_average = unit_price_sum / @items.all.count
    difference_sum = @items.all.map {|item| (price_average - item.unit_price)**2 }.sum
    price_stdrd_dev = Math.sqrt((difference_sum / @items.all.count).abs)
    @items.all.find_all  {|item|  item.unit_price > price_average + (price_stdrd_dev * 2)}
  end

  def invoice_quantity_per_merchant
    merchant_ids = @invoices.all.map { |invoice| invoice.merchant_id}
    hash = Hash.new(0)
    merchant_ids.each do |id|
      hash[id] += 1
    end
    invoices_per_merchant = hash.values.sort
  end

  def merchant_invoice_num(merchant_id)
    invoice_num = 0
    @invoices.all.each do |invoice|
      if invoice.merchant_id == merchant_id
        invoice_num += 1
      end
    end
    invoice_num
  end

  def average_invoices_per_merchant
    (invoice_quantity_per_merchant.sum.to_f / invoice_quantity_per_merchant.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    difference_sum = invoice_quantity_per_merchant.map {|invoice_quantity| (average_invoices_per_merchant - invoice_quantity)**2 }.sum
    price_stdrd_dev = Math.sqrt((difference_sum.to_f / invoice_quantity_per_merchant.count).abs).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = average_invoices_per_merchant + average_items_per_merchant_standard_deviation * 2
    @merchants.all.find_all { |merchant| merchant_invoice_num(merchant.id) > threshold}
  end

  def bottom_merchants_by_invoice_count
    threshold = average_invoices_per_merchant - average_items_per_merchant_standard_deviation * 2
    @merchants.all.find_all { |merchant| merchant_invoice_num(merchant.id) < threshold}
  end

  def top_days_by_invoice_count
    num_to_days = {0 => "Sunday",
                   1 => "Monday",
                   2 => "Tuesday",
                   3 => "Wednesday",
                   4 => "Thursday",
                   5 => "Friday",
                   6 => "Saturday"}
    invoice_days = invoices.all.map { |invoice| invoice.created_at.wday}
    invoices_by_day = Hash.new(0)
    invoice_days.each do |day|
      invoices_by_day[day] += 1
    end
    invoice_average_per_day = (invoices_by_day.values.sum.to_f / invoices_by_day.values.count).round(2)
    diff_sum = invoices_by_day.values.map { |invoices| (invoice_average_per_day - invoices)**2}.sum
    invoice_stdrd_dev = Math.sqrt((diff_sum.to_f / invoices_by_day.values.count).abs).round(2)
    days = []
    threshold = invoice_average_per_day + invoice_stdrd_dev
    invoices_by_day.each do |day, invoices|
      if (invoices > threshold.round)
        days.push(num_to_days[day])
      end
    end
    days
  end

  def invoice_status(status)
    num_status = 0
    invoices.all.each do |invoice|
      if invoice.status == status
        num_status += 1
      end
    end
    ((num_status.to_f / invoices.all.count.to_f) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions_by_invoice = @transactions.find_all_by_invoice_id(invoice_id)
    transactions_by_invoice.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(id)
    total_price_by_quantity = @invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    total_price_by_quantity.sum
  end
  
  def total_revenue_by_date(date) #yyyy-mm-dd
    ii = @invoice_items.find_all_by_date(date)
    ii.map do |invoice|
      invoice.unit_price
    end.sum.to_f.truncate(2)
  end
end
