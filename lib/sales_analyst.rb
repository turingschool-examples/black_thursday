require 'bigdecimal'
require 'csv'
require 'date'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
    # @sales_analyst = sales_analyst
  end

  def average_items_per_merchant
   (items_count / merchants_count.to_f).round(2)
    # total number of items per merchant
    # divided by total number of merchants
  end

  def items_count
    sales_engine.items.all.count
  end

  def merchants_count
    sales_engine.merchants.all.count
  end

  def average_items_per_merchant_standard_deviation
    sum = 0
    sales_engine.merchants.all.each do |merchant|
      sum += (sales_engine.items.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant)**2
    end
    Math.sqrt(sum / (merchants_count - 1)).round(2)
    # take average_items_per_merchant 
    # find the standard deviation
        # (item_count_ForEachMerchant - average_items_per_merchant) ^ 2
        # add all of these up for every single merchant = sum
            #  sum / (by total number of merchants - 1) = answer
        # sqrt(answer) = sd
    # Float
  end

  def merchants_with_high_item_count
    high_item_count = sales_engine.merchants.all.find_all do |merchant|
      (sales_engine.items.find_all_by_merchant_id(merchant.id).count) > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
    # find_all merchants with more than ONE sd ABOVE the average number of items offered
    # return array of merchants
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices_per_merchant = []
      items_per_merchant = sales_engine.items.find_all_by_merchant_id(merchant_id)
      items_per_merchant.each do |item|
        item_prices_per_merchant << (item.unit_price / 100)
      end
      avg = ((item_prices_per_merchant.sum) / items_per_merchant.count)
      avg = BigDecimal(avg, 4)
      # price of each item for that merchant
      # add it all together
      # divide by number of items for THAT merchant
        # divide ^ by 100 because items are in cents and we want dollars
      #BigDecimal
    end

  def average_average_price_per_merchant
    all_merchant_averages = []
    sales_engine.merchants.all.each do |merchant|
      all_merchant_averages  << average_item_price_for_merchant(merchant.id)
    end
    ((all_merchant_averages.sum) / merchants_count).truncate(2)
    # use average_item_price_for_merchant(merchant_id)
    # add the sum of all averages between ALL of the merchants
    # divided by number of total merchants
    # BigDecimal
  end

  def average_price_for_all_items
    total_price_for_all_items = sales_engine.items.all.sum do |item|
      item.unit_price
    end
    avg_price_of_items = (total_price_for_all_items / items_count).round(2)
  end

  def average_standard_deviation_for_all_items
    sum = 0
    sales_engine.items.all.each do |item|
      sum += (item.unit_price - average_price_for_all_items)**2
    end
    items_standard_deviation = Math.sqrt(sum / (items_count - 1)).round(2)
  end

  def golden_items
    sales_engine.items.all.find_all do |item|
      item.unit_price > (average_price_for_all_items + (average_standard_deviation_for_all_items * 2))
    end
  end
    # find average_item_price_for_all_items
      # all item prices / all items count
    # find all items SD
    # find all items that are TWO sd ABOVE the average_item_price_for_all_items
    # returns an array of item objects
    # it is an Item Class


   # ======================================= #

  def average_invoices_per_merchant
    (invoice_count / merchants_count.to_f).round(2)
  end

  def invoice_count
    sales_engine.invoices.all.count
  end
  
  def average_invoices_per_merchant_standard_deviation
    sum = 0
    sales_engine.merchants.all.each do |merchant|
      sum += (sales_engine.invoices.find_all_by_merchant_id(merchant.id).count - average_invoices_per_merchant)**2
    end
    Math.sqrt(sum / (merchants_count - 1)).round(2)
  end
  
  def top_merchants_by_invoice_count
    high_invoice_count = sales_engine.merchants.all.find_all do |merchant|
      (sales_engine.invoices.find_all_by_merchant_id(merchant.id).count) > (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
    end
  end
  
  def bottom_merchants_by_invoice_count
    low_invoice_count = sales_engine.merchants.all.find_all do |merchant|
      (sales_engine.invoices.find_all_by_merchant_id(merchant.id).count) < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    end
  end

  def invoice_count_per_day
    invoices_per_day = {}
    days_of_the_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    days_of_the_week.each do |day|
      day_count = sales_engine.invoices.all.find_all do |invoice|
        invoice.created_at.strftime("%A") == day
      end
      invoices_per_day[day] = day_count.count
    end
    invoices_per_day
  end

  def average_invoices_per_day
    (invoice_count.to_f / invoice_count_per_day.count).truncate(2)
  end

  def average_invoice_standard_deviation
    sum = 0
    invoice_count_per_day.each do |day, count|
      sum += ((count - average_invoices_per_day)**2)
    end
    invoice_standard_deviation = Math.sqrt(sum / (invoice_count_per_day.count - 1)).round(2)
  end

  def top_days_by_invoice_count
    top_days = []
    invoice_count_per_day.each do |day, count|
      top_days << day if count > (average_invoices_per_day + average_invoice_standard_deviation)
    end
    top_days
  end

  def invoice_status(status)
    case status
    when :pending
      return (sales_engine.invoices.find_all_by_status(:pending).count / (invoice_count.to_f) *100).round(2)
    when :shipped 
      return (sales_engine.invoices.find_all_by_status(:shipped).count / (invoice_count.to_f) *100).round(2)
    else 
      return (sales_engine.invoices.find_all_by_status(:returned).count / (invoice_count.to_f) *100).round(2)
    end
  end
  
  # ============= ITERATION 3 METHODS ========================== #
  
  def invoice_paid_in_full?(invoice_id) 
    return false if sales_engine.transactions.find_all_by_invoice_id(invoice_id).empty?

    sales_engine.transactions.find_all_by_invoice_id(invoice_id).all? do |transaction|
      transaction.result == :success
    end
  end
  
  def invoice_total(invoice_id)
    total = sales_engine.invoice_items.find_all_by_invoice_id(invoice_id).sum do |invoice_item|
      invoice_item.quantity * (invoice_item.unit_price / 100)
    end

    total = BigDecimal(total, 7)
  end
  
  
  # ============== ITERATION 4 METHODS ========================= #
  
  def invoice_by_date(date)
    sales_engine.invoices.find_all_by_date(date)
  end
  
  def total_revenue_by_date(date)
    invoice_by_date(date).sum do |invoice|
      invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
    end
  end
  
  def top_revenue_earners(top_number = 20)
    merchants_ranked_by_revenue.shift(top_number)
  end
  
  def merchants_ranked_by_revenue
    ### Try min max by?
    hash = {}
    sales_engine.merchants.all.each do |merchant|
      hash[merchant] = revenue_by_merchant(merchant.id)
    end
    ranked = hash.sort_by{|key, value| -value}
    ranked.map{|merchant| merchant[0]}
  end
  
  # def merchants_with_pending_invoices
  #   sales_engine.merchants.all.find_all do |merchant|
  #     sales_engine.invoices.find_all_by_merchant_id(merchant.id).any? do |invoice|
  #       invoice.status == :pending
  #     end
  #   end
  # end
  def merchants_with_pending_invoices
    sales_engine.merchants.all.find_all do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id).any? do |invoice|
        sales_engine.transactions.find_all_by_invoice_id(invoice.id).all? do |transaction|
          transaction.result == "failed"
        end
      end
    end
  end

  def merchants_with_only_one_item
    sales_engine.merchants.all.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).length == 1
    end
  end
  
  def merchants_with_only_one_item_registered_in_month(month)
    month_hash = {}

    sales_engine.merchants.all.find_all do |merchant|
      invoices_for_month_and_one_item = sales_engine.invoices.find_all_by_merchant_id(merchant.id).find_all do |invoice|
          (invoice_by_month?(month, invoice) && invoice.status != :pending) && (invoice_only_one_item?(invoice) && invoice_paid_in_full?(invoice.id))
        end

      month_hash[merchant] = invoices_for_month_and_one_item
    end

    one_in_a_month = month_hash.find_all do |keys, values|
      values.length == 1
    end

    one_in_a_month.map{|merchant|merchant[0]}
    
  end
  
  def revenue_by_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    # formatted in dollars
    total = invoices_paid_in_full_by_merchant(merchant).sum do |invoice|
      invoice_total(invoice.id)
    end

    total.round(2)
  end
  
  def invoices_paid_in_full_by_merchant(merchant)
    invoices = sales_engine.invoices.find_all_by_merchant_id(merchant.id)
    invoices.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    hash = {}

    array_of_items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    
    array_of_items.each do |item|
      hash[item] = sales_engine.invoice_items.find_all_by_item_id(item.id).sum{|invoice_item| invoice_item.quantity}
    end

    ordered_array = hash.sort_by{|k,v| -v}
    top_number = ordered_array.first[1]
    top_pairs = ordered_array.find_all{|pair| pair[1] == top_number}
    top_items = top_pairs.map{|pair| pair[0]}
  end
  
  def best_item_for_merchant(merchant_id)
    # item in terms of revenue generated
  end

  def invoice_by_month?(month, invoice)
    invoice.created_at.strftime("%B") == month
  end
  
  def invoice_only_one_item?(invoice)
    sales_engine.invoice_items.find_all_by_invoice_id(invoice.id).length == 1
  end

end
