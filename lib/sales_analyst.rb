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

    merchants = se.merchants.all
    standard_deviation(merchants)
  end

  def standard_deviation(collection)

    n = collection.count

    item_prices = collection.map {|item| item.items.count}  
    mean = item_prices.reduce(:+)/n.to_f
    diff_squared = item_prices.map{ |item| ((item - mean)**2) }
    do_math = diff_squared.reduce(:+)
    result = Math.sqrt(do_math/(n-1)).round(2)
  end

  def merchants_with_high_item_count
    #find merchants selling more than 1 SD higher
    merchants = se.merchants.all
    average = average_items_per_merchant
    sd = average_items_per_merchant_standard_deviation

    merchants.select{ |merchant| merchant.items.count > (average + sd) }
    
  end
  
  def average_item_price_for_merchant(merchant_id)
    items = se.items.find_all_by_merchant_id(merchant_id)
    prices = items.map { |item| item.unit_price }
    price_sum = prices.reduce(:+)
    ((price_sum / items.count).round(2))
  end

  def average_average_price_per_merchant
    merchants = se.merchants.all    
    prices = merchants.map{ |merchant| average_item_price_for_merchant(merchant.id) }
    average_average = (prices.reduce(:+) / merchants.count).round(2)
  end

  def golden_items    
    merchants = se.merchants.all
    items = se.items.all

    sd_price = standard_deviation_for_price

    average_price = merchants.map {|merchant| average_item_price_for_merchant(merchant.id) }
    average_price = average_price.reduce(:+)/(merchants.count).to_f

    golden = items.select{ |item| item.unit_price > ((2 * sd_price) + average_price) }
  end

  def standard_deviation_for_price
    items = se.items.all

    n = items.count

    item_prices = items.map {|item| item.unit_price}  
    mean = item_prices.reduce(:+)/n.to_f
    diff_squared = item_prices.map{ |price| ((price - mean)**2) }
    do_math = diff_squared.reduce(:+)
    result = Math.sqrt(do_math/(n-1)).round(2)
  end
end
