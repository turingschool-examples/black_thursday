require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine, :items, :merchants, :invoices, :transactions

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = sales_engine.items.all
    @merchants = sales_engine.merchants.all
    @invoices = sales_engine.invoices.all
    @transactions = sales_engine.transactions.all
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(diff_items_per_merchant / (merchants.count - 1)).round(2)
  end

  def diff_items_per_merchant
    merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      sum + (merchant_items.count - average_items_per_merchant)**2
    end
  end
  
  def merchants_with_high_item_count
    double = average_items_per_merchant_standard_deviation * 2
    merchants.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > double
    end
  end
  
  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    if items.empty?
      BigDecimal(0)
    else
      price = items.sum do |item|
        item.unit_price
      end
      (price / items.count).round(2)
    end
  end
  
  def average_average_price_per_merchant
    total_price = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.sum
    (total_price / merchants.count).round(2)
  end
  
  def golden_items
    prices = items.map { |item| item.unit_price }
    avg = (prices.sum / prices.count).round(2)
    std_dev = Math.sqrt(total_diff(prices, avg) / (prices.length - 1)).round(2)
    items.find_all do |item|
      item.unit_price.to_f >= avg+ (std_dev * 2)
    end
  end

  def total_diff(prices, avg)
    prices.inject(0) do |sum, price|
      sum + (price - avg)**2
    end.round(2)
  end

  def average_invoices_per_merchant
   (@invoices.count/@merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = merchants_invoices.inject(0) do |sum, invoice|
      sum += (invoice.count - mean)**2
    end
    return Math.sqrt(sum/(merchants.length - 1)).round(2)
  end
  
  def merchants_invoices
    @merchants.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id)
    end
  end

  def merchant_ids_collection(merchants_invoices)
    merchants_invoices.map do |invoices_collection|
    invoices_collection[0].merchant_id
    end
  end

  def chosen_merchants(merchants_invoices)
    merchant_ids_collection(merchants_invoices).map do |merchant|
      @sales_engine.merchants.find_by_id(merchant)
    end
  end


  def top_merchants_by_invoice_count
    merchants_with_invoices = []
     merchants_invoices.each do |invoices_array|
      if invoices_array.count > (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
      merchants_with_invoices.push(invoices_array)
      end
    end
    chosen_merchants(merchants_with_invoices)
  end

  def bottom_merchants_by_invoice_count
    merchants_with_invoices = []
     merchants_invoices.each do |invoices_array|
      if invoices_array.count < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
      merchants_with_invoices.push(invoices_array)
      end
    end
    chosen_merchants(merchants_with_invoices)
  end
  
  def dates
    @invoices.map do |invoice|
      invoice.created_at
    end
  end

  def weekdays
    dates.map do |date|
      %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday][date.wday]
    end
  end

  def weekday_counts
    weekday_counts = weekdays.each_with_object(Hash.new(0)) do |weekday, counts|
      counts[weekday] += 1
    end
  end

  def weekday_invoice_avg
    weekday_invoice_avg = 0
    weekday_counts.each do |day, count|
      weekday_invoice_avg += count
    end
    weekday_invoice_avg / 7
  end

  def weekday_inv_stndrd_dev
    weekday_inv_stndrd_dev = 0
    weekday_counts.each do |day, count|
      weekday_inv_stndrd_dev += (count - weekday_invoice_avg)**2
    end
    Math.sqrt(weekday_inv_stndrd_dev/6).to_f.round(2)
  end

  def top_days_by_invoice_count
    top_days = []
    weekday_counts.each do |day, count|
      if count > (weekday_invoice_avg + weekday_inv_stndrd_dev)
        top_days.push(day)
      end
    end
    top_days
  end

  def invoice_status(input)
    status_array = []
    invoices.each do |invoice|
      if invoice.status == input
        status_array.push(invoice.status)
      end
    end
    result = (status_array.count/invoices.count.to_f * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    purchases = sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    if purchases.empty?
      false
    else
      purchases.any? do |purchase|
        purchase.result == :success
      end
    end
  end

  def invoice_total(invoice_id)
    invoice_items = sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.sum { |invoice_item| invoice_item.quantity * invoice_item.unit_price}
  end

  def merchants_with_pending_invoices    
   invoices_not_paid_in_full = @invoices.map do |invoice|
      if !invoice_paid_in_full?(invoice.id)
        invoice
      end
    end.compact
    
    merchants_pending = invoices_not_paid_in_full.map do |invoice|
      sales_engine.merchants.find_by_id(invoice.merchant_id)
    end.uniq
  end

  def merchants_with_only_one_item
    merchants.select do |merchant| 
      sales_engine.items.find_all_by_merchant_id(merchant.id).length == 1
    end
  end

  def total_revenue_by_date(date)
    invoices_by_date = sales_engine.invoices.all.find_all do |invoice|
      date.strftime('%B %d, %Y') == invoice.created_at.strftime('%B %d, %Y')
    end
    invoice_items_by_date = sales_engine.invoice_items.find_all_by_invoice_id(invoices_by_date[0].id)
    invoice_items_by_date.sum { |invoice| invoice.unit_price * invoice.quantity }
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_created_in_month = merchants.select do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end
    grouped_items = items.group_by { |item| item.merchant_id }
    grouped_items.transform_keys! do |merchant_id|
      sales_engine.merchants.find_by_id(merchant_id)
    end
    answer = grouped_items.keep_if do |merchant, items|
      merchants_created_in_month.include?(merchant)
    end
    answer.keep_if { |_merch, items| items.count == 1 }
    answer.keys
  end

  def revenue_by_merchant(id)
    all_invoices = sales_engine.invoices.find_all_by_merchant_id(id)
    all_invoices.sum do |invoice|
     invoice_total(invoice.id)
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant_invoices = sales_engine.invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoice_items = merchant_invoices.flat_map {|merchant_invoice| sales_engine.invoice_items.find_all_by_invoice_id(merchant_invoice.id)}
    item_hash = merchant_invoice_items.group_by {|invoice_item| invoice_item.item_id}
    item_quantity = item_hash.transform_values{|invoice_items|invoice_items.map{|invoice_item|invoice_item.quantity}}
    item_quantity.transform_values!{|value|value.sum}
    item_quantity.transform_keys! do |item|
      sales_engine.items.find_by_id(item)
    end
    most_sold_items = item_quantity.max_by{|k,v| v}
    most_sold_items.delete_if{|n| n.class == Integer}
  end

  def top_revenue_earners(n= 20)
    merchants_ranked_by_revenue[0..n - 1]
  end

  def merchants_ranked_by_revenue
    rank = sales_engine.merchants.all.sort_by do |merchant|
      revenue(merchant.id)
    end.reverse
  end

  def revenue(merchant_id)    
    sales_engine.invoices.find_all_by_merchant_id(merchant_id).inject(BigDecimal(0)) do |sum, invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice_items = sales_engine.invoice_items.find_all_by_invoice_id(invoice.id)
        sum + (invoice_items.sum{|invoice_item|invoice_item.quantity*invoice_item.unit_price})
      else
        sum
      end
    end
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = []
    sales_engine.invoices.find_all_by_merchant_id(merchant_id).each do |invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice_items.push(sales_engine.invoice_items.find_all_by_invoice_id(invoice.id))
      end
    end
      invoice_item_revenues = []
      invoice_items.each do |invoice_itemz|
        invoice_itemz.each do |invoice_item|
        invoice_item_revenues.push([invoice_item, (invoice_item.quantity * invoice_item.unit_price)])
        end
      end
      result = invoice_item_revenues.sort_by do |item_revenue|
        item_revenue[1]
      end
      id = result.last[0].item_id
      best_item = sales_engine.items.find_by_id(id)
    end
end
