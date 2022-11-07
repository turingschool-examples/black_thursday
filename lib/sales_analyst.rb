require 'pry'
require 'bigdecimal'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './transaction_repository'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative './invoice_item'
require_relative './customer'
require_relative './transaction'
require_relative './mathable'

class SalesAnalyst
  include Mathable
  
  attr_reader :merchants, :items, :invoices, :customers, :transactions, :invoice_items

  def initialize(merchants,items,invoices,invoice_items,customers,transactions)
    @merchants = merchants
    @items = items
    @invoices = invoices
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
  end

  def average_items_per_merchant
    avg(items_per_merchant).to_f.round(2)
  end

  def average_items_per_merchant_standard_deviation    
    stdev(items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    avg = avg(items_per_merchant)
    stdev = stdev(items_per_merchant)

    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count > avg + stdev
    end
  end

  def average_item_price_for_merchant(id)
    prices = @items.find_all_by_merchant_id(id).map do |item|
      item.unit_price
    end

    avg(prices).round(2)
  end

  def average_average_price_per_merchant
    avg_prices = @merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    avg(avg_prices).truncate(2)
  end

  def golden_items
    avg = avg(item_prices)
    stdev = stdev(item_prices)

    @items.all.select do |item|
      item.unit_price > avg + 2*stdev
    end
  end

  # Iteration 5

  def top_buyers(num_buyers = 20)
    @customers.all.sort_by do |cust|
      customer_spent(cust.id)
    end.reverse![0..num_buyers-1]
  end

  # Helper methods

  def find_customer_by_id(cust_id)
    @customers.all.find do |cust|
      cust.id == cust_id
    end
  end

  def customer_spent(cust_id)
    customer_invoices(cust_id).sum do |cust_inv|
      invoice_paid_in_full?(cust_inv.id) ? invoice_revenue(cust_inv.id) : 0
    end
  end

  def customer_invoices(cust_id)
    @invoices.all.find_all do |invoice|
      invoice.customer_id == cust_id
    end
  end

  def invoice_revenue(invoice_id)
    invoice_items_by_invoice_id(invoice_id).sum do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end

  def invoice_items_by_invoice_id(invoice_id)
    @invoice_items.all.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end
  
  def items_per_merchant
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def item_prices
    @items.all.map do |item|
      item.unit_price
    end
  end

  # Invoices

  def average_invoices_per_merchant
    avg(invoices_per_merchant).to_f.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    stdev(invoices_per_merchant).round(2)
  end

  def invoices_per_merchant
    @merchants.all.map do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).count
    end
  end

  def top_merchants_by_invoice_count
    avg = avg(invoices_per_merchant)
    stdev = stdev(invoices_per_merchant)

    @merchants.all.find_all do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).count > avg + (stdev * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    avg = avg(invoices_per_merchant)
    stdev = stdev(invoices_per_merchant)

    @merchants.all.find_all do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).count < avg - (stdev * 2)
    end
  end

  def invoices_days_of_week
    @invoices.all.map do |invoice|
    invoice.created_at.wday
    end
  end

  def invoice_days_count
    # [708, 696, 692, 741, 718, 701, 729]
    days_count = []
    days_count << invoices_days_of_week.count(0)
    days_count << invoices_days_of_week.count(1)
    days_count << invoices_days_of_week.count(2)
    days_count << invoices_days_of_week.count(3)
    days_count << invoices_days_of_week.count(4)
    days_count << invoices_days_of_week.count(5)
    days_count << invoices_days_of_week.count(6)
    days_count
  end

  def average_invoices_per_day
  (invoice_days_count.sum / 7.0).round(2)
  end

  def average_invoices_per_week_standard_deviation
    Math.sqrt(invoice_week_sum_diff_square / (invoice_days_count.length - 1)).round(2)
  end

  def invoice_week_sum_diff_square
    invoice_days_count.map do |count|
      (count - average_invoices_per_day)**2
    end.sum
  end

  def one_over_standard_dev
    average_invoices_per_week_standard_deviation + average_invoices_per_day
  end

  def top_days_by_invoice_count # refactor with group_by, possibly refactor invoice_days_count to hash?
    days_of_week = []
    array = invoice_days_count
    hash = {
      sunday:     array[0],
      monday:     array[1],
      tuesday:    array[2],
      wednesday:  array[3],
      thursday:   array[4],
      friday:     array[5],
      saturday:   array[6]
            }
    hash.each do |day, count|
      if count > one_over_standard_dev
         days_of_week << day.to_s.capitalize
      end
    end
    days_of_week
  end

  def find_transactions_by_invoice_id(invoice_id) # there can be multiple transactions per invoice
    transactions.all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def invoice_paid_in_full?(invoice_id)
    find_transactions_by_invoice_id(invoice_id).any? do |transaction|
      transaction.result == :success
    end
  end

  def find_invoice_item_by_invoice_id(invoice_id) 
    invoice_items.all.find_all do |invoice_item|
    invoice_item.invoice_id == invoice_id
    end
  end

  def invoice_total(invoice_id)

    ii = find_invoice_item_by_invoice_id(invoice_id)
    ii.collect do |i|
      if invoice_paid_in_full?(invoice_id)
      i.quantity.to_i * i.unit_price
      else
        0
      end
    end.sum
  end
  
  def invoice_status(status)
  invoice_count = invoices.all.select { |invoice| invoice.status == status }
  ((invoice_count.count).to_f / (invoices.all.count) * 100).round(2)
  end

  def total_revenue_by_date(date)
    invoice_date = find_i_by_date(date)
    invoice_date.map do |invoice|
      invoice_total(invoice.id)
    end.inject(:+)
  end

  def find_i_by_date(date)
    x = invoices.all.find_all do |invoice|
      invoice.created_at.to_date === date.to_date
    end
  end

  def total_merchant_revenue(merchant_id)
    total = 0 
    total_h = {}
    x = @invoices.find_all_by_merchant_id(merchant_id)
    x.each do |invoice|
      if invoice_paid_in_full?(invoice.id)
        total += invoice_total(invoice.id)
      end
    end
    total.round(2)
  end

  def top_revenue_earners(rank = 20)
    merchants.all.max_by(rank) do |merchant|
      total_merchant_revenue(merchant.id)
    end
  end

  def merchants_with_pending_invoices
    pending_invoices = []
    invoices.all.each do |invoice|
      if (invoice.status != :shipped || :returned) && !invoice_paid_in_full?(invoice.id)
        pending_invoices << invoice
      end
    end.uniq
    pending_invoices2 = pending_invoices.map do |invoice|
      invoice.merchant_id
      end.uniq
    pending_invoices2.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end  
       
  def merchants_with_only_one_item
    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
  end



  def invoices_by_merchant(merchant_id)
    @invoices.all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def invoice_items_by_merchant(merchant_id)
    invoices_by_merchant(merchant_id).collect do |invoice|
      @invoice_items.all.find_all do |invoice_item|
        invoice_item.invoice_id == invoice.id
      end
    end.flatten
  end

  def revenue_by_merchant(merchant_id)
    invoice_items_by_merchant(merchant_id).sum do |invoice_item|
     invoice_item.quantity.to_i * invoice_item.unit_price
    end
  end
  
    
  def most_sold_item_for_merchant(merchant_id)
  end

  def best_item_for_merchant(merchant_id)
  end

end