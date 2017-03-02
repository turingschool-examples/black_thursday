
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
  end

  def average_items_per_merchant_standard_deviation
    merchants = se.merchants.all
    items = merchants.map {|merchant| merchant.items.count}
    standard_deviation(items)
  end

  def standard_deviation(collection)
    n = collection.count
    mean = average(collection.reduce(:+), n.to_f)
    diff_squared = collection.map{ |item| ((item - mean)**2) }
    sum_of_squares = diff_squared.reduce(:+)
    sd = Math.sqrt(sum_of_squares/(n-1)).round(2)
  end

  def merchants_with_high_item_count
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
    prices = merchants.map{ |merc| average_item_price_for_merchant(merc.id) }
    average(prices.reduce(:+), merchants.count).round(2)
  end

  def golden_items
    merchants = se.merchants.all
    items = se.items.all
    sd_price = standard_deviation_for_price
    ave_price = merchants.map {|merc| average_item_price_for_merchant(merc.id)}
    ave_price = ave_price.reduce(:+)/(merchants.count).to_f
    golden = items.select{|item| item.unit_price > ((2 * sd_price) + ave_price)}
  end

  def standard_deviation_for_price
    item_prices = se.items.all.map {|item| item.unit_price}
    standard_deviation(item_prices)
  end

  def average_items_per_merchant
    average(se.items.all.count, se.merchants.all.count).round(2)
  end

  def average_invoices_per_merchant
    average(se.invoices.all.count, se.merchants.all.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices = se.merchants.all.map {|merchant| merchant.invoices.count}
    standard_deviation(invoices)
  end

  def merchants_by_invoice(comparison)
    average = average_invoices_per_merchant
    sd = average_invoices_per_merchant_standard_deviation
    case comparison
    when "top"
      se.merchants.all.select {|merc| merc.invoices.count > ( average + (sd*2))}
    when "bottom"
      se.merchants.all.select {|merc| merc.invoices.count < ( average - (sd*2))}
    end
  end

  def top_merchants_by_invoice_count
    merchants_by_invoice("top")
  end

  def bottom_merchants_by_invoice_count
    merchants_by_invoice("bottom")
  end

  def top_days_by_invoice_count
    days = Hash.new(0)
    se.invoices.all.each{|invoice| days[invoice.created_at.strftime("%A")] += 1}
    average = average(days.values.reduce(:+), 7)
    sd = standard_deviation(days.values)
    days.keys.select { |day| days[day] > (average + sd) }
  end

  def invoice_status(status)
    total = se.invoices.all.count.to_f
    matching = se.invoices.all.select{|invoice| invoice.status == status}.count
    ((matching/total) * 100).round(2)
  end

  def total_revenue_by_date(date)
    invoices = se.invoices.all
    invoices = invoices.select{|ii| ii.created_at.to_date === date.to_date}
    invoices.inject(0) { |sum, invoice| sum + invoice.total }
  end

  def top_revenue_earners(num=20)
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
    pending = se.invoices.all.select{|inv| inv.is_paid_in_full? == false}
    pending.map {|inv| se.merchants.find_by_id(inv.merchant_id)}.uniq
  end

  def merchants_with_only_one_item
    item_count = Hash.new(0)
    se.items.all.each { |item| item_count[item.merchant_id] += 1 }
    ones = item_count.select { |merchant_id, item_count| item_count == 1 }
    ones.keys.map { |merchant_id| se.merchants.find_by_id(merchant_id) }.uniq
  end

  def merchants_with_only_one_item_registered_in_month(month)
    ones = merchants_with_only_one_item
    ones.select{|merc| Time.parse(merc.created_at).strftime("%B") == month}
  end

  def revenue_by_merchant(merchant_id)
    invoices = se.invoices.all
    revenues = Hash.new(0)
    invoices.each {|invoice| revenues[invoice.merchant_id] += invoice.total }
    sorted = revenues.sort_by{ |k, v| -v }.to_h
    revenues[merchant_id]
  end

  def find_the_invoice_items(item_id)
    item_invoices = se.invoice_items.find_all_by_item_id(item_id)
  end

  def paid_invoices(invoice_items)
    invoice_items.select do |invoice_item|
      id = invoice_item.invoice_id
      se.invoices.find_by_id(id).is_paid_in_full?
    end
  end

  def sold_count(merchant_id)
    sold_count = Hash.new(0)
    items = se.items.find_all_by_merchant_id(merchant_id)
    items.each do |item|
      invoice_items = paid_invoices(find_the_invoice_items(item.id))
      total = invoice_items.inject(0){|sum, ii| sum + ii.quantity}
      sold_count[item] += total
    end
    sold_count
  end

  def most_sold_item_for_merchant(merchant_id)
    sold_count = sold_count(merchant_id)
    max = sold_count.values.max
    max_items = Hash[sold_count.select { |k, v| v == max}].keys
  end

  def least_sold_item_for_merchant(merchant_id)
    sold_count = sold_count(merchant_id)
    min = sold_count.values.min
    min = Hash[sold_count.select { |k, v| v == min}].keys
  end

  def best_item_for_merchant(merchant_id)
  end

  def sold_zero(item_id)
    se.invoice_items.find_all_by_item_id(item_id).empty?
  end

  def merchant_zero_sellers(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    merchant.items.select{ |item| sold_zero(item.id) }
  end
end
