require 'csv'
require 'pry'
require 'time'
require 'bigdecimal'
require_relative '../lib/sales_engine'
require_relative '../lib/calculations_module'

class SalesAnalyst
  include Calculations

  attr_reader :se
            

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    merchants = se.merchants.all.length.to_f
    items = se.items.all.length.to_f
    (items/merchants).round(2)
  end

  def create_all_merchant_ids
    se.merchants.all.map do |merchant|
      merchant.id
    end
  end

  def average_items_per_merchant_standard_deviation
   standard_deviation(items_per_merchant)
  end

 def items_per_merchant
   se.merchants.all.map do |merchant|
      merchant.items.length
    end
  end

  def invoices_per_merchant
    se.merchants.all.map do |merchant|
      merchant.invoices.length
    end
  end

  def merchants_with_high_item_count
    variance = threshold(items_per_merchant, 1)
    se.merchants.all.find_all do |merchant|
      merchant.num_items >= variance
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    aggregate_price = items.map do |item|
      item.unit_price
    end.reduce(:+).round(2)
    (aggregate_price/items.count).round(2)
  end
    
  def average_average_price_per_merchant
    all_merchants = se.merchants.all
    sum = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+).round(2)
    (sum/all_merchants.length).round(2)
  end

  def golden_items
    all_items = se.items.all
    array_of_prices = all_items.map do |item|
      item.unit_price
    end
    gold = threshold(array_of_prices, 2)
    all_items.find_all do |gold_items| 
      gold_items.unit_price > gold
    end
  end

  def invoice_status(status)
    invoices_with_status = all_invoices_by_status[status].length.to_f
    total_invoices = se.total_invoices
    (invoices_with_status/total_invoices * 100).round(2)
  end
  
  def all_invoices_by_status
    se.invoices.all.group_by do |invoice|
      invoice.status
    end
  end

  def average_invoices_per_merchant
    merchants = se.merchants.all.length.to_f
    invoices = se.invoices.all.length.to_f
    (invoices/merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    invoice_count = threshold(invoices_per_merchant, 2)
    tops = se.merchants.all.find_all do |merchant|
      merchant.num_invoices > invoice_count
    end
    tops
  end
   
  def bottom_merchants_by_invoice_count
    invoice_count = threshold(invoices_per_merchant, -2)
    bottoms = se.merchants.all.find_all do |merchant|
      merchant.num_invoices < invoice_count
    end
    bottoms
  end

  def find_day(date)
    date.strftime("%A")
  end

  def group_invoices_by_day
    days_hash = Hash.new(0)
    se.invoices.all.each do |invoice|
      days_hash[find_day(invoice.created_at)] += 1
    end
    days_hash
  end

  def invoices_count_by_day
    highest_day_count = threshold(group_invoices_by_day.values, 1)
    group_invoices_by_day.find_all do |day|
      day if day.last >= highest_day_count
    end
  end

  def top_days_by_invoice_count
    invoices_count_by_day.map do |day|
      day.first
    end
  end

  def total_revenue_by_date(date)
    date = Time.parse(date.to_s).strftime("%D")
    invoices_array = se.invoices.all.find_all do |invoice|
      invoice.created_at.strftime("%D") == date
    end
    sum = invoices_array.reduce(0) do |sum, invoice|
      sum += invoice.total
    end
    BigDecimal.new(sum).round(2)
  end

  def top_revenue_earners(num = 20)
    #returns the specified number of top revenue earners
    #if no num is provided, it provides the top 20 merchants by revenue
    merchants_ranked_by_revenue[0...num]
  end

  def merchants_with_pending_invoices
    se.merchants.all.select do |merchant|
      merchant.invoices.any? {|invoice| !invoice.is_paid_in_full?}
    end
  end

  def merchants_with_only_one_item
    se.merchants.all.select do |merchant|
      merchant.num_items == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B").include?(month)
    end
  end
  
  def total_invoice_items_revenue(total, invoice)
    invoice.find_invoice_items.inject(0) do |total, item|
      total += item.unit_price * item.quantity 
    end
  end

  def revenue_by_merchant(merchant_id)
    paid_invoices = se.merchants.find_all_invoices_by_id(merchant_id).select do |invoice|
      invoice.is_paid_in_full?
    end
    revenue = paid_invoices.reduce(0) do |total, invoice|
      total += total_invoice_items_revenue(total, invoice)
    end
    BigDecimal.new(revenue).round(2)
  end

  def merchants_ranked_by_revenue
    sorted_merchants = se.merchants.all.sort_by do |merchant| 
      revenue_by_merchant(merchant.id)
    end.reverse
  end

  def most_sold_item_for_merchant(merchant_id)
  #returns an item array if there is a tie, or a single item if there isn't'
    all_quantities = find_all_invoice_items_for_merchant(merchant_id).map do |invoice_item|
      invoice_item.map do |item|
        Hash[item.item_id => item.quantity]
      end
    end.flatten
    all_quantity_per_item = all_quantities.inject do |item, element|
      item.merge(element) do |k, old, present|
        old + present
      end
    end
    top_quantity = 0
    top_items = []
    all_quantity_per_item.each do |key, value|
      if value > top_quantity
        top_quantity = value
        top_items.pop
        top_items << key
      elsif value == top_quantity
        top_items << key
      end
    end
    top_items.map do |item|
      se.items.find_by_id(item)
    end
  end

  def find_all_invoice_items_for_merchant(merchant_id)
   invoices_with_ids = se.find_all_invoices_by_id(merchant_id).map do |invoice|
      invoice.id if invoice.is_paid_in_full?
    end.compact
    invoice_items = invoices_with_ids.map do |invoice_id|
      se.find_invoice_items(invoice_id)
    end
  end

  def best_item_for_merchant(merchant_id)
    all_revenue = find_all_invoice_items_for_merchant(merchant_id).map do |invoice_item|
      invoice_item.map do |item|
        item_revenue = item.unit_price * item.quantity
        Hash[item.item_id => item_revenue]
      end
    end.flatten
    all_revenue_per_item = all_revenue.inject do |item, element|
      item.merge(element) do |k, old, present|
       old + present
      end
    end
    top_value = 0
    best_item = 0
    all_revenue_per_item.each do |key, value|
      if value > top_value
        top_value = value
        best_item = key
      end
    end
    se.items.find_by_id(best_item)    
  end

end