require 'pry'
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

class SalesAnalyst
  attr_reader :merchants, :items, :invoices, :customers, :transactions, :invoice_items

  def initialize(merchants,items,invoices,invoice_items,customers,transactions)

    @merchants = merchants
    @items = items
    @invoices = invoices
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
    @invoice_items = invoice_items
  end

  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation    
    Math.sqrt(sum_square_diff_items/(item_counts.length-1)).round(2)
  end

  def merchants_with_high_item_count
    avg = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count > avg + stdev
    end
  end

  def average_item_price_for_merchant(id)
    sum = @items.find_all_by_merchant_id(id).sum do |item|
      item.unit_price
    end
    avg = sum.to_f / @items.find_all_by_merchant_id(id).count
    BigDecimal(avg,4)
  end

  def average_average_price_per_merchant
    sum = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    avg = sum / @merchants.all.count
    avg.truncate(2)
  end

  def golden_items
    avg = average_item_price
    stdev = Math.sqrt(sum_square_diff_golden/(@items.all.size-1)).round(2)
    @items.all.select do |item|
      item.unit_price > avg + 2*stdev
    end
  end

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
    sum = 0
    customer_invoices(cust_id).each do |cust_inv|
      invoice_paid_in_full?(cust_inv.id) ? sum += invoice_revenue(cust_inv.id) : 0
    end
    sum
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

  def sum_square_diff_items
    item_counts.map do |count|
      (count - average_items_per_merchant)**2
    end.sum
  end
  
  def item_counts
    @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def sum_square_diff_golden
    @items.all.map do |item|
      (item.unit_price - average_item_price)**2
    end.sum
  end

  def average_item_price
    sum = @items.all.sum do |item|
      item.unit_price
    end
    (sum / @items.all.size).round(2)
  end

  def average_invoices_per_merchant
    (@invoices.all.count / @merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    # binding.pry
    Math.sqrt(invoice_sum_square_diff / (invoice_count.length - 1)).round(2)
  end

  def invoice_sum_square_diff
    invoice_count.map do |count|
      (count - average_invoices_per_merchant)**2
    end.sum
  end

  def invoice_count
    @merchants.all.map do |merchant|
      @invoices.find_all_by_merchant_id(merchant.id).count
      # binding.pry
    end
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation
    @merchants.all.find_all do |merchant|
    @invoices.find_all_by_merchant_id(merchant.id).count > average + (stdev * 2)
    # binding.pry
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
    @invoices.find_all_by_merchant_id(merchant.id).count < average - (stdev * 2)
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
    # binding.pry
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
      i.quantity.to_i * i.unit_price
    end.sum.to_f
  end

  def invoice_status(status)
  invoice_count = invoices.all.select { |invoice| invoice.status == status }
  ((invoice_count.count).to_f / (invoices.all.count) * 100).round(2)
  end


# def merchants_with_pending_invoices
#     @merchants.all.find_all do |merchant|  maybe possible to go straight to invoices?
#     merchant.invoices.any? |invoice|      believe any? will skip any that dont have an invoice, think they all do so this could be redundant.
#     !invoices.is_paid_in_full?            depending on how are paid in full method works? i dont love ! but wasnt sure how else to write it.
# end

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