class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end  
  
  def average_items_per_merchant
    items_total = se.items.all.count
    merchants_total = se.merchants.all.count
    (items_total/merchants_total.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    #Check with sample size and 3.26 SD
    sample = se.merchants.all.sample(500)
    items_of_merchants = sample.map {|merchant| merchant.items.count}  
    sum = items_of_merchants.reduce(:+)
    mean = sum/500.0


    mean = items_of_merchants.reduce(:+)/500.0

    do_math = items_of_merchants.map{ |item| ((item - mean)**2) }
    do_math = do_math.reduce(:+)
    result = Math.sqrt(do_math/(500-1)).round(2)
    
  end

    # sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
  def merchants_with_high_item_count

  end

  #Let’s find the average price of a merchant’s items (by supplying the merchant ID):
  # sa.average_item_price_for_merchant(12334159) # => BigDecimal
  def average_item_price_for_merchant

  end

end
