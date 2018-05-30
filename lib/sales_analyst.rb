require_relative 'sales_engine.rb'
require 'pry'

class SalesAnalyst

  def initialize(sales_engine)
    @items = sales_engine.items
    @merchants = sales_engine.merchants
    @invoices = sales_engine.invoices
    @id_counts = {}
    @average_items = average_items_per_merchant
    @items_standard_deviation = average_items_per_merchant_standard_deviation
    @average_item_price = average_total_item_price
    @price_standard_deviation = item_price_standard_deviation
    @average_invoices = average_invoices_per_merchant
    @invoice_standard_deviation = average_invoices_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    sum = items_per_merchant.reduce(0.0) do |total, count|
      total += count
    end
    average = (sum / items_per_merchant.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant, @average_items)
  end

  def standard_deviation(array, average)
    count_less_one = (array.count - 1)
    sum = array.reduce(0.0) do |total, amount|
      total += (amount - average) ** 2
    end
    standard_deviation = ((sum / count_less_one) ** (1.0/2)).round(2)
  end

  def items_grouped_by_merchant
    @items.all.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant
    array_of_arrays_of_items_per_merchant = items_grouped_by_merchant.values
    array_of_arrays_of_items_per_merchant.map do |array|
      array = array.count
    end
  end

  def id_counts
    items_grouped_by_merchant.keys.zip(items_per_merchant)
  end

  def merchants_with_high_item_count
    high_count = @average_items + @items_standard_deviation
    good_merchants = id_counts.map do |id, count|
      if count >= high_count
        @merchants.find_by_id(id)
      end
    end
    good_merchants.compact
  end

  def average_item_price_for_merchant(id)
    items = @items.find_all_by_merchant_id(id)
    sum = items.reduce(0) do |total, item|
      total += item.unit_price
    end
    (sum / items.count).round(2)
  end


  def average_average_price_per_merchant
    sum = @merchants.all.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
    end
    (sum / @merchants.repository.count).round(2)
  end

  def average_item_prices_for_each_merchant
    @merchants.all.map do |merchant|
      merchant = average_item_price_for_merchant(merchant.id)
    end
  end

  def item_price_standard_deviation
    standard_deviation(all_item_prices, @average_item_price).round(2)
  end

  def all_item_prices
    @items.all.map do |item|
      item = item.unit_price
    end
  end

  def average_total_item_price
    sum = @items.all.reduce(0) do |total, item|
      total += item.unit_price
    end
    sum / @items.all.count
  end

  def golden_items
    golden_items = @items.all.reduce([]) do |array, item|
      if item.unit_price >= (@average_item_price + (@price_standard_deviation * 2))
        array << item
      end
      array
    end
    golden_items
  end

  ###### Invoices begin below, the copy and paste shows we arent DRY.

  def invoices_grouped_by_merchant
    @invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def invoices_per_merchant
    array_of_arrays_of_invoices_per_merchant = invoices_grouped_by_merchant.values
    array_of_arrays_of_invoices_per_merchant.map do |array|
      array = array.count
    end
  end

  def average_invoices_per_merchant
    sum = invoices_per_merchant.reduce(0.0) do |total, count|
      total += count
    end
    average = (sum / invoices_per_merchant.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant, @average_invoices)
  end

  def invoice_counts_for_each_merhant
    invoices_grouped_by_merchant.merge(invoices_grouped_by_merchant) do |id, invoices|
      invoices.count
    end
  end

  def top_merchants_by_invoice_count
    high_count = @average_invoices + (@invoice_standard_deviation * 2)
    top_merchants = []
    invoice_counts_for_each_merhant.each do |id, count|
        top_merchants << @merchants.find_by_id(id) if count > high_count
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    low_count = @average_invoices - (@invoice_standard_deviation * 2)
    bottom_merchants = []
    invoice_counts_for_each_merhant.each do |id, count|
        bottom_merchants << @merchants.find_by_id(id) if count < low_count
    end
    bottom_merchants
  end

end
