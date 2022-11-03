class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    # total number of items per merchant
    # divided by total number of merchants
    # Float
  end

  def average_items_per_merchant
    # total number of items per merchant
      # add up the sums 
    # divided by total number of merchants
    # Float
  end

  def average_items_per_merchant_standard_deviation
    # take average_items_per_merchant 
    # find the standard deviation
        # (item_count_ForEachMerchant - average_items_per_merchant) ^ 2
        # add all of these up for every single merchant = sum
            #  sum / (by total number of merchants - 1) = answer
        # sqrt(answer) = sd
    # Float

  end

  def merchants_with_high_item_count
    # use average_items_per_merchant_standard_deviation 
    # find_all merchants with more than ONE sd ABOVE the average number of items for sale
    # return array of merchants
  end

  def average_item_price_for_specific_merchant(merchant_id)
    # total of all item unit_price per merchant(use merchant ID)
    # divide by total number of items for THAT merchant
    # BigDecimal
  end

  def average_item_price_for_all_merchants
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
      # add up sums
    # divided by total number of merchants? (or invoices)
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

  def invoice_status(:status)
    # find_all_by_status(:status)
    # count how many invoices of THAT given status
    # divide by total invoices
    # x100
    # do this for all three statuses
  end
end