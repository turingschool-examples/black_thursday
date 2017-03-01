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
    @average = @items_per_merchant.reduce(:+) / @group_by_number_of_items.size.to_f
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
    day_sales = @sales_engine.invoice_items.all.find_all do |invoice_item|
      @sales_engine.invoices.find_by_id(invoice_item.invoice_id).created_at == date
      require "pry"; binding.pry
    end
    day_sales.inject(0) do |sum, sale|
      sum + sale.quantity.to_f * sale.unit_price
    end
==========================================================
danny code
-----------
def total_revenue_by_date(date)
    invoices_from_date(date).reduce(0) do |sum, invoice|
      sum + invoice.total
    end
  end

  def invoices_from_date(date)
    engine.invoices.find_all_by_created_date(date)
  end
===========================================================


  end

end
