require 'pry'
class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    average_items_per_merchant
    average_average_price_per_merchant
    average_invoices_per_merchant
    average_invoices_per_day
    invoices_per_day_std_dev
  end

  def average_items_per_merchant
    @group_by_number_of_items = @sales_engine.items.all.group_by do |item|
      item.merchant_id
    end
    @items_per_merchant = @group_by_number_of_items.map do |key, value|
      value.count
    end
    @average =@items_per_merchant.reduce(:+)/@group_by_number_of_items.size.to_f
    @average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    @std_dev = Math.sqrt(@items_per_merchant.map do |number|
      (number - @average)**2
    end.inject(:+) / (@items_per_merchant.length - 1)).round(2)
    @std_dev
  end

  def merchants_with_high_item_count
    average_items_per_merchant_standard_deviation
    hash = {}
    @group_by_number_of_items.each do |merchant, items|
      hash[merchant] = items.length
    end
    hash.select do |merchant, number|
      merchant if number > (@average + @std_dev)
     end.map do |merchant_id, value|
       @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    average = @group_by_number_of_items[merchant_id].map do |item|
      item.unit_price
    end.reduce(:+) / (@group_by_number_of_items[merchant_id].count)
    average.round(2)
  end

  def average_average_price_per_merchant
    all_ids = @group_by_number_of_items.map do |merchant_id, value|
      merchant_id
    end
    @all_average_price = all_ids.map do |id|
      average_item_price_for_merchant(id)
    end
    @average_of_averages = (@all_average_price.reduce(:+) / (all_ids.count))
    @average_of_averages = @average_of_averages.round(2)
    @average_of_averages
  end

  def price_std_dev
    all_prices = @sales_engine.items.all.map do |item|
      item.unit_price
    end
    @price_dev = Math.sqrt(all_prices.map do |number|
      (number - average_average_price_per_merchant)**2
    end.inject(:+) / (all_prices.length - 1)).round(2)
    @price_dev
  end

  def golden_items
    price_std_dev
    @sales_engine.items.all.select do |item|
      item if item.unit_price > ((@price_dev * 2) + @average_of_averages)
    end
  end

  def average_invoices_per_merchant
    @group_by_number_of_invoice = @sales_engine.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
    @invoice_per_merchant = @group_by_number_of_invoice.map do |key, value|
      value.count
    end
    @average_invoices = @invoice_per_merchant.reduce(:+) / @group_by_number_of_invoice.size.to_f
    @average_invoices = @average_invoices.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(@invoice_per_merchant.map do |number|
      (number - @average_invoices)**2
    end.inject(:+) / (@invoice_per_merchant.length - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    hash = {}
    @group_by_number_of_invoice.each do |merchant, invoices|
      hash[merchant] = invoices.length
    end
    top_merchants = hash.select do |merchant, number|
      merchant if number > (@average_invoices + (average_invoices_per_merchant_standard_deviation * 2))
     end.map do |merchant_id, value|
       @sales_engine.merchants.find_by_id(merchant_id)
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    hash = {}
    @group_by_number_of_invoice.each do |merchant, invoices|
      hash[merchant] = invoices.length
    end
    bottom_merchants = hash.select do |merchant, number|
      merchant if number < (@average_invoices - (average_invoices_per_merchant_standard_deviation * 2))
     end.map do |merchant_id, value|
       @sales_engine.merchants.find_by_id(merchant_id)
    end
    bottom_merchants
  end

  def average_invoices_per_day
    @group_by_sales_day = @sales_engine.invoices.all.group_by do |invoice|
      invoice.day_created
    end
    @invoice_per_day = @group_by_sales_day.map do |key, value|
      value.count
    end
    @average_sales_day = @invoice_per_day.reduce(:+) / @group_by_sales_day.size.to_f
    @average_sales_day = @average_sales_day.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    Math.sqrt(@invoice_per_merchant.map do |number|
      (number - @average_invoices)**2
    end.inject(:+) / (@invoice_per_merchant.length - 1)).round(2)
  end
  def invoices_per_day_std_dev
    Math.sqrt(@invoice_per_day.map do |invoice|
      (invoice - @average_sales_day)**2
    end.inject(:+) / (@invoice_per_day.length - 1)).round(2)
  end

  def top_days_by_invoice_count
    hash = {}
    @group_by_sales_day.each do |day, sales|
      hash[day] = sales.length
    end
    top_days = hash.select do |day, number|
      day if number > (@average_sales_day + invoices_per_day_std_dev)
    end.map do |key, value|
      key
    end
    top_days
  end

  def invoice_status(status_search)
    number_of_each ={}
    @sales_engine.invoices.all.group_by do |invoice|
      invoice.status
    end.each do |status, invoices|
      number_of_each[status] = invoices.count
    end
    ((number_of_each[status_search] / @sales_engine.invoices.all.length.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    @sales_engine.invoices.find_all_by_date(date).reduce(0) do |sum, invoice|
      sum + invoice.invoice_item_array.reduce(0) do |total, invoice_item|
        total + (invoice_item.unit_price * invoice_item.quantity.to_f)
      end
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices_grouped_by_merchant[merchant_id].reduce(0) do |sum, invoice|
      sum + invoice.total
    end
  end

  def invoices_grouped_by_merchant
    @sales_engine.invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def find_invoice_items_for_merchant(id)
    invoices = @sales_engine.merchants.find_by_id(id).invoices.find_all do |inv|
      inv.is_paid_in_full?
    end
    invoices.map do |invoice|
      invoice.invoice_item_array
    end
  end

  def group_by_item_id(merch_id)
    inv_items = find_invoice_items_for_merchant(merch_id).flatten
    inv_items.group_by do |inv_item|
      inv_item.item_id
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    group = find_quantity_of_each_item_id(merchant_id)
    max = group.max_by do |_key, value|
      value
      end[1]
    highest = group.select {|key, value| value == max}.to_a
    highest.map! {|array| @sales_engine.items.find_by_id(array[0])}
  end

  def find_quantity_of_each_item_id(merch_id)
    group = group_by_item_id(merch_id)
    group.each do |key,value|
      group[key] = value.reduce(0){|sum, item| sum + item.quantity.to_f}
    end
  end

  def revenue_by_item_id(merchant_id)
    group = group_by_item_id(merchant_id)
    group.each do |key,value|
      group[key] = value.reduce(0){|s, i| s + i.quantity.to_f * i.unit_price}
    end
  end

  def best_item_for_merchant(id)
    group = revenue_by_item_id(id)
    max = group.max_by { |key, value| value }[1]
     highest = group.select {|key, value| value == max}.to_a
    highest.map! {|array| @sales_engine.items.find_by_id(array[0])}[0]
  end

  def merchants_with_only_one_item_registered_in_month(month)
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.items.length == 1 &&
      merchant.creation_month.downcase == month.downcase
    end
  end

  def merchants_with_only_one_item
    @sales_engine.merchants.all.find_all do |merchant|
      merchant.items.length == 1
    end
  end

  def merchants_with_pending_invoices
    merchants = pending_invoices.group_by do |invoice|
      invoice.merchant_id
    end
    merchants.map do |key, _value|
      @sales_engine.merchants.find_by_id(key)
    end.uniq
  end

  def pending_invoices
    @sales_engine.invoices.all.find_all { |invoice| !invoice.is_paid_in_full? }
  end

  def top_revenue_earners(x=20)
    top_20 = revenues_for_all.sort_by do |merchant_id, revenue|
      revenue
    end.reverse[0..(x-1)]
    top_20.map do |id, revenue|
      @sales_engine.merchants.find_by_id(id)
    end
  end

  def revenues_for_all
    revenues = {}
    invoices_grouped_by_merchant.each do |id, value|
      revenues[id] = value.inject(0) do |sum, invoice|
        sum + invoice.total
      end
    end
    revenues
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(@sales_engine.merchants.all.length)
  end
end
