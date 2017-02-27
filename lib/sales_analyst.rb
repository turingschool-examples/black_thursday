
class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end  
  
  def average(total_sum, count) 
    (total_sum / count.to_f)
  end


  def average_items_per_merchant
    average(se.items.all.count, se.merchants.all.count).round(2)

    # items_total = se.items.all.count
    # merchants_total = se.merchants.all.count
    # (items_total/merchants_total.to_f).round(2)
  end
  

  def average_items_per_merchant_standard_deviation
    merchants = se.merchants.all
    items = merchants.map {|merchant| merchant.items.count}  
    standard_deviation(items)
  end

  def standard_deviation(collection)

    # n = collection.count
    # item_prices = collection.map {|item| item.items.count}  
    # mean = average(item_prices.reduce(:+), n.to_f)

    # diff_squared = item_prices.map{ |item| ((item - mean)**2) }
    # sum_of_squares = diff_squared.reduce(:+)
    # result = Math.sqrt(sum_of_squares/(n-1)).round(2)

    n = collection.count
    mean = average(collection.reduce(:+), n.to_f)
    diff_squared = collection.map{ |item| ((item - mean)**2) }
    sum_of_squares = diff_squared.reduce(:+)
    sd = Math.sqrt(sum_of_squares/(n-1)).round(2)

  end

  def merchants_with_high_item_count
    #find merchants selling more than 1 SD higher
    average = average_items_per_merchant
    sd = average_items_per_merchant_standard_deviation
    se.merchants.all.select{ |merchant| merchant.items.count > (average + sd) }
    
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
    average(prices.reduce(:+), merchants.count).round(2)

  end

  def golden_items    
    merchants = se.merchants.all
    items = se.items.all

    sd_price = standard_deviation_for_price
    #use average_price_per_merchant here??
    average_price = merchants.map {|merchant| average_item_price_for_merchant(merchant.id) }
    average_price = average_price.reduce(:+)/(merchants.count).to_f

    golden = items.select{ |item| item.unit_price > ((2 * sd_price) + average_price) }
  end


  

  def standard_deviation_for_price
    # items = se.items.all
    # n = items.count

    item_prices = se.items.all.map {|item| item.unit_price}  
    standard_deviation(item_prices)
    # mean = item_prices.reduce(:+)/n.to_f
    # diff_squared = item_prices.map{ |price| ((price - mean)**2) }
    # do_math = diff_squared.reduce(:+)
    # result = Math.sqrt(do_math/(n-1)).round(2)
  end




  ##business SalesAnalyst

  def average_items_per_merchant
    average(se.items.all.count, se.merchants.all.count).round(2)

    # items_total = se.items.all.count
    # merchants_total = se.merchants.all.count
    # (items_total/merchants_total.to_f).round(2)
  end


  def average_invoices_per_merchant
    average(se.invoices.all.count, se.merchants.all.count).round(2)
  end


  def average_invoices_per_merchant_standard_deviation
    #get invoices per merchant
    invoices = se.merchants.all.map {|merchant| merchant.invoices.count}  
    standard_deviation(invoices)
  end



#How to refactor top and bottom merchants methods? They're identical except for the final comparison grab
    # #use this for later methods?
  def merchants_by_invoice(comparison)
    average = average_invoices_per_merchant
    sd = average_invoices_per_merchant_standard_deviation
    case comparison
    when "top"
      se.merchants.all.select { |merchant| merchant.invoices.count > ( average + (sd*2)) }    
    when "bottom"
      se.merchants.all.select { |merchant| merchant.invoices.count < ( average - (sd*2)) }
      # binding.pry
    end
  end

  def top_merchants_by_invoice_count
    merchants_by_invoice("top")
  end

  def bottom_merchants_by_invoice_count
    merchants_by_invoice("bottom")
  end

  def top_days_by_invoice_count
    #days with invoice count > 1 sd above mean

    days = Hash.new(0)
    se.invoices.all.each { |invoice| days[invoice.created_at.strftime("%A")] += 1 }
    average = average(days.values.reduce(:+), 7)
    sd = standard_deviation(days.values)
    days.keys.select { |day| days[day] > (average + sd) }

  end



  def invoice_status(status)
    total = se.invoices.all.count.to_f
    matching = se.invoices.all.select{ |invoice| invoice.status == status }.count
    ((matching/total) * 100).round(2)
  end

end



se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoices => "./data/invoices.csv" })
ir = se.items
mr = se.merchants
invr = se.invoices
sa = SalesAnalyst.new(se)
sa.top_days_by_invoice_count
# binding.pry

""