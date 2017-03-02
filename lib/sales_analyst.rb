
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
    # binding.pry
    matching = se.invoices.all.select{ |invoice| invoice.status == status }.count
    ((matching/total) * 100).round(2)
  end

  def total_revenue_by_date(date)
    #go to invoices
    #select only invoices that match date
    #grab unit_price off of invoice_items, sum

    #Time.parse().to_date?
    # date = Time.parse(date).to_date
    #Date.strptime("09-28-2004","%m-%d-%Y")

    invoices = se.invoices.all.select { |ii| ii.created_at.to_date === date.to_date }
    invoices.inject(0) { |sum, invoice| sum + invoice.total }
  end

  def top_revenue_earners(num=20)
    # invoices = se.invoices.all
    # revenues = Hash.new(0)
    # invoices.each { |invoice| revenues[invoice.merchant_id] += invoice.total }
    # sorted = revenues.sort_by{ |k, v| -v }.to_h
    # # sorted = sorted.reverse
    # top = sorted.keys.first(num)
    # top.map { |id| se.merchants.find_by_id(id) }

    merchants = merchants_ranked_by_revenue
    top = merchants.first(num)
  end

  def bottom_revenue_earners(num = 20)
    merchants = merchants_ranked_by_revenue
    bottom = merchants.last(num)

  end

  def merchants_ranked_by_revenue
    invoices = se.invoices.all
    revenues = Hash.new(0)
    invoices.each {|invoice| revenues[invoice.merchant_id] += invoice.total }
    sorted = revenues.sort_by{ |k, v| -v }.to_h
    sorted.keys.map { |id| se.merchants.find_by_id(id) }
  end

  def merchants_with_pending_invoices
    #this first attempt is incorrect, see Note on I-4 instructions
    # pending = se.invoices.all.select{ |invoice| invoice.status == :pending }

    pending = se.invoices.all.select { |invoice| invoice.is_paid_in_full? == false }
    pending.map { |invoice| se.merchants.find_by_id(invoice.merchant_id) }.uniq
  end
  
  def merchants_with_only_one_item
    # binding.pry
    item_count = Hash.new(0)
    se.items.all.each { |item| item_count[item.merchant_id] += 1 }
    ones = item_count.select { |merchant_id, item_count| item_count == 1 }
    ones.keys.map { |merchant_id| se.merchants.find_by_id(merchant_id) }.uniq
  end

  def merchants_with_only_one_item_registered_in_month
    ones = merchants_with_only_one_item
    invoices = se.invoices.all.select { |ii| ii.created_at.to_date === date.to_date }


    # added created_at to merchant repo and merchant
    # added merchant.created_at
    #need to compare months and select
  end


end



# se = SalesEngine.from_csv({:items => "./data/items_fixture.csv", :merchants => "./data/merchants_fixture.csv", :invoices => "./data/invoices_fixture.csv" })
# ir = se.items
# mr = se.merchants
# invr = se.invoices
# invoice = invr.all[0]
# sa = SalesAnalyst.new(se)
# sa.top_days_by_invoice_count
# binding.pry

""