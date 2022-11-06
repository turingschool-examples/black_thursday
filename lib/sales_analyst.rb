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
  
  def top_days_by_invoice_count
    sales_engine.invoices.all.find_all do |invoice|
    # require 'pry'; binding.pry
      invoice.created_at
    end 
    # weekday = created_at.strftime[("%A")]
    # use top_merchants_by_invoice_count (?)
    # find which days that invoices created at are more than ONE sd ABOVE the mean
    average_invoices_per_merchant_standard_deviation
    # array of (days) strings
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
  
  # ======================================= #

  def invoice_paid_in_full?(invoice_id) 
    # returns true if the Invoice with the corresponding id is paid in full
  end
  
  def invoice_total(invoice_id)
    # returns the total $ amount of the Invoice with the corresponding id
    # Failed charges should never be counted in revenue totals or statistics
    # An invoice is considered paid in full if it has a successful transaction
  end
end