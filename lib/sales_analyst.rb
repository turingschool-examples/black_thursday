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
    #Checked with sample size and 3.26 SD

    n = se.merchants.all.count.to_f

    sample = se.merchants.all.sample(n)

    items_of_merchants = sample.map {|merchant| merchant.items.count}  
    sum = items_of_merchants.reduce(:+)
    mean = sum/n

    mean = items_of_merchants.reduce(:+)/n

    do_math = items_of_merchants.map{ |item| ((item - mean)**2) }
    do_math = do_math.reduce(:+)
    result = Math.sqrt(do_math/(n-1)).round(2)
    
  end



  def merchants_with_high_item_count
    #find merchants selling more than 1 SD higher
    merchants = se.merchants.all
    average = average_items_per_merchant
    sd = average_items_per_merchant_standard_deviation

    merchants.select{ |merchant| merchant.items.count > (average + sd) }
    # sa.merchants_with_high_item_count # => [merchant, merchant, merchant]
  end


  
  def average_item_price_for_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.map { |item| item.unit_price }
    price_sum = prices.reduce(:+)
    ((price_sum / items.count).round(2))
  end



# Then we can sum all of the averages and find the average price across all merchants (this implies that each merchant’s average has equal weight in the calculation):

  def average_average_price_per_merchant
    merchants = se.merchants.all    
    prices = merchants.map{ |merchant| average_item_price_for_merchant(merchant.id) }
    average_average = (prices.reduce(:+) / merchants.count).round(2)
    # binding.pry 
  end

end
