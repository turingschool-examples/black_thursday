require 'bigdecimal'
require_relative 'standard_deviation'

class SalesAnalyst
  include StandardDeviation

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    num_items = sales_engine.items.all.length.to_f
    num_merchants = sales_engine.merchants.all.length
    (num_items/num_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_count_by_merchant)
  end

  def merchants_with_high_item_count
    threshold = threshold(item_count_by_merchant, 1)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.items.length >= threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    aggregate_price = merchant.items.reduce(0) do |sum, item|
      sum + item.unit_price
    end
    (aggregate_price/merchant.items.length).round(2)
  end

  def average_average_price_per_merchant
    sum_averages = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    num_merchants = sales_engine.merchants.all.length
    (sum_averages/num_merchants).round(2)
  end

  def golden_items
    threshold = threshold(item_price_array, 2)
    sales_engine.items.all.find_all do |item|
      item.unit_price_to_dollars >= threshold
    end
  end

  def average_invoices_per_merchant
    num_invoices = sales_engine.invoices.all.length.to_f
    num_merchants = sales_engine.merchants.all.length
    (num_invoices/num_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_count_by_merchant)
  end

  def top_merchants_by_invoice_count
    threshold = threshold(invoice_count_by_merchant, 2)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.length >= threshold
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = threshold(invoice_count_by_merchant, -2)
    sales_engine.merchants.all.find_all do |merchant|
      merchant.invoices.length <= threshold
    end
  end

  def top_days_by_invoice_count
    threshold = threshold(group_invoices_by_day_count.values, 1)
    group_invoices_by_day_count.delete_if do | key, value |
      value <= threshold
    end.keys
  end

  def invoice_status(status)
    (group_invoices_status[status].length.to_f /
    sales_engine.invoices.all.length * 100).round(2)
  end

  #======================

  def total_revenue_by_date(date) #not tested yet
    invoices = find_all_invoices_by_date(date)
    invoices.reduce(0) do |sum, invoice|
      sum += invoice.total
    end
  end


  def find_all_invoices_by_date(date)#helper_function, passing test
    date = Time.parse(date).strftime('%D')
    sales_engine.invoices.all.select do |invoice|
      invoice.created_at.strftime('%D') == date
    end
  end


#=============
  def top_revenue_earners(num=20)#not tested,test below first
    hash = generate_merchant_revenue_hash
    hash.sort_by {|merchant, revenue| revenue}.reverse.to_h
    hash.keys[0..num]
  end

  def merchants_ranked_by_revenue #not tested
    top_revenue_earners(sales_engine.merchants.length)
  end

  def generate_merchant_revenue_hash#helper function, not tested, test revenue by merchant first
    merchant_revenue_hash = {}
    sales_engine.merchants.all do |merchant|
      merchant_revenue_hash[merchant] = revenue_by_merchant(merchant.id)
    end
    merchant_revenue_hash
  end

#===========

  def merchants_with_pending_invoices
    sales_engine.merchants.all.select do |merchant|
      merchant.invoices.any? {|invoice| !invoice.is_paid_in_full?}
    end
  end

  #NOT NEEDED?
  # def find_pending_invoices #helper function
  #
  # end

#==============

  def merchants_with_only_one_item
    sales_engine.merchants.all.select do |merchant|
      merchant.items.length == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    all_with_one = merchants_with_only_one_item
    all_with_one.select do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

#==============

  def revenue_by_merchant(merchant_id)
    all_invoices = sales_engine.find_all_by_merchant_id(merchant_id)
    all_invoices.reduce(0) do |cuml_total, invoice|
      cuml_total += invoice.total
    end
  end

  #================

  def find_paid_invoices_by_merchant(merchant_id)
    #helper function
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    merchant.invoices.select do |invoice|
      invoice.is_paid_in_full?
    end
  end

  def generate_item_hash_for_invoice(invoice_id)
    all_items = sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
    hash = {}
    all_items.each do |invoice_item|
      hash[invoice_item] = [invoice_item.quantity, invoice_item.unit_price]
    end
    hash.inject({}) {|h, (k, v)| h[k] = [v[0], v[0]*v[1]]; h}
    #{"it1"=>[5, 25.0], "it2"=>[4, 14.0]}
  end

  def generate_item_hash_for_merchant(merchant_id) #helper function {item => [quantity, revenue]}
    cuml_array = []
    find_paid_invoices_by_merchant.each do |invoice|
      cuml_array.push(generate_item_hash_for_invoice(merchant_id))
    end

    #can above be:
    # cuml_array = find_paid_invoices_by_merchant.reduce([]) do |cuml, invoice|
    #   cuml.push(generate_item_hash_for_invoice(merchant_id))
    # end


    #this works below, but trying to break it up to be under 80
    # cuml_array.inject{|cuml_hash, hash| cuml_hash.merge(hash){|key, start, addl| [start, addl].transpose.map {|x| x.reduce(:+)}}}

    #could break this out into separate function
    cuml_array.inject do |cuml_hash, hash|
      cuml_hash.merge(hash) do |key, start, addl|
        [start, addl].transpose.map {|x| x.reduce(:+)}
      end
    end
  end

#OLD
#   invoices = find_paid_invoices_by_merchant
#   cuml_hash = {}
#   invoices.each do |invoice|
#     item_hash = generate_item_hash_for_invoice(merchant_id)
#     item_hash.each do |key, value|
#       if cuml_hash[key]
#         cuml_hash[key] = [cuml_hash[key][0] + value[0], cuml_hash[key][1] + value[1]]
#       else
#         cuml_hash[key] = [value[0], value[1]]
#       end
#     end
#   end
# end

  def most_sold_item_for_merchant(merchant_id)
    merchant_hash = generate_item_hash_for_merchant(merchant_id)
    sorted = merchant_hash.sort_by {|k, v| v[0]}
    sorted.keys[0]
  end

  def best_item_for_merchant(merchant_id)
    #may be dumb to redo this - could store it as merchant i_var
    merchant_hash = generate_item_hash_for_merchant(merchant_id)
    sorted = merchant_hash.sort_by {|k, v| v[1]}
    sorted.keys[0]
  end


#=======================DONE=====

  def item_price_array
    sales_engine.items.all.map do |item|
      item.unit_price_to_dollars
    end.sort
  end

  def item_price_average
    average(item_price_array).round(2)
  end

  def item_price_standard_deviation
    standard_deviation(item_price_array)
  end

  def item_count_by_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.items.length
    end.sort
  end

  def item_count_standard_deviation
    standard_deviation(item_count_by_merchant)
  end

  def invoice_count_by_merchant
    sales_engine.merchants.all.map do |merchant|
      merchant.invoices.length
    end.sort
  end

  def find_day_of_week(date)
    date.strftime("%A")
  end

  def group_invoices_by_day
    sales_engine.invoices.all.group_by do |invoice|
      find_day_of_week(invoice.created_at)
    end
  end

  def group_invoices_by_day_count
    hash = group_invoices_by_day
    hash.each do | day, invoices |
      hash[day] = invoices.length
    end
  end

  def average_invoices_per_day
    average(group_invoices_by_day_count.values).round(2)
  end

  def group_invoices_status
    sales_engine.invoices.all.group_by do |invoice|
      invoice.status
    end
  end

end
