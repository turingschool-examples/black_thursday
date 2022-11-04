require 'bigdecimal'
require 'csv'

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
        item_prices_per_merchant << item.unit_price 
      end
      avg = ((item_prices_per_merchant.sum) / items_per_merchant.count)
      avg = BigDecimal(avg, 4) * 100
      
      #mode and value
      # 0.1666665e

      # [4] pry(main)> a = 1665.6666666666667
      # => 1665.6666666666667
      # (a).round(-2)
      # => 1700
      # (a).round(2)
      # => 1665.67
      # (a).round(2)
      # avg_bd = BigDecimal.new(avg,4)
      # price of each item for that merchant
      # add it all together
      # divide by number of items for THAT merchant
      #BigDecimal
    end

  def average_average_price_per_merchant
    all_merchant_averages = []
    sales_engine.merchants.all.each do |merchant|
      require 'pry'; binding.pry
      all_merchant_averages << merchant.average_item_price_for_merchant(merchant.id)
      require 'pry'; binding.pry
    end
    (all_merchant_averages.sum) / merchants_count
    # use average_item_price_for_specific_merchant(merchant_id)
    # add the sum of all averages between ALL of the merchants
    # divided by number of total merchants

    # BigDecimal
  end

  def golden_items
    # find_all items that are TWO sd ABOVE the average_item_price_for_all_merchants
    # returns an array of item objects
  end

   # ======================================= #

  def average_invoices_per_merchant
    # total number of invoices per merchant
    # divided by total number of merchants?
  end

  def average_invoices_per_merchant_standard_deviation
     # take average_invoices_per_merchant 
    # find the standard deviation
        # (invoice_count_ForEachMerchant - average_invoice_per_merchant) ^ 2
        # add all of these up for every single merchant = sum
            #  sum / (by total number of merchants - 1) = answer
        # sqrt(answer) = sd
    # Float
  end

  def top_merchants_by_invoice_count
    # merchants that are TWO sd ABOVE average_invoices_per_merchant_standard_deviation
    # returns an array of merchants
  end
  
  def bottom_merchants_by_invoice_count
    # merchants that are TWO sd BELOW average_invoices_per_merchant_standard_deviation
    # returns an array of merchants
  end

  def top_days_by_invoice_count
    # use top_merchants_by_invoice_count (?)
    # find which days that invoices created at are more than ONE sd ABOVE the mean
    # array of (days) strings
  end

  def invoice_status(status)
    # find_all_by_status(:status)
    # count how many invoices of THAT given status
    # divide by total invoices
    # x100
    # do this for all three statuses
  end
end