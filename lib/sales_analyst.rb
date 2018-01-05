require 'bigdecimal'

class SalesAnalyst

  def initialize(sales_engine = "")
    @sales_engine = sales_engine
  end

  def item_array_maker
    @sales_engine.all_merchants.map do |merchant|
      item_counter(merchant.id)
    end
  end

  def average_items_per_merchant
    long_number = item_array_maker.reduce(0) do |sum, number|
      sum += number
    end/item_array_maker.count.to_f
    long_number.round(2)
  end

  def item_counter(id = 0)
    num = @sales_engine.items.find_all_by_merchant_id(id).count
    @sales_engine.assign_item_count(id, num)
    num
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    square = item_array_maker.map do |item|
      (item-mean) ** 2
    end.sum
    ((square/(item_array_maker.length-1)) ** (0.5)).round(2)
  end

  def mean_plus_standard_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    base_line = mean_plus_standard_deviation
    @sales_engine.all_merchants.select do |merchant|
      merchant.item_count > base_line
    end
  end

  def average_item_price_for_merchant(id)
    BigDecimal(merchant_items_sum(id) / @sales_engine.items.find_all_by_merchant_id(id).length).round(2)
  end

  def merchant_items_sum(id)
    @sales_engine.items.find_all_by_merchant_id(id).reduce(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_price_per_merchant
    @sales_engine.all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def average_price_per_merchant_sum
    average_price_per_merchant.sum
  end

  def average_average_price_per_merchant
    BigDecimal(average_price_per_merchant_sum / average_price_per_merchant.length).floor(2)
  end

  def price_standard_deviation
    mean = average_average_price_per_merchant
    square = @sales_engine.all_items.map do |item|
      (item.unit_price - mean) ** 2
    end.sum
    ((square/(@sales_engine.items.items.length-1)) ** (0.5)).floor(2)
  end

  def golden_items
    double_deviation = average_average_price_per_merchant + price_standard_deviation * 2
    @sales_engine.all_items.select do |item|
      item.unit_price > double_deviation
    end
  end

  def count_invoices
    @sales_engine.all_invoices.count.to_f
  end

  def count_merchants
    @sales_engine.all_merchants.count.to_f
  end

  def invoice_array_maker
    @sales_engine.all_merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant
    (count_invoices / count_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    square = invoice_array_maker.map do |invoice|
      (invoice-mean) ** 2
    end.sum
    ((square/(invoice_array_maker.length-1)) ** (0.5)).round(2)
  end

  def top_merchants_by_invoice_count
    base_line = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation*2)
    @sales_engine.all_merchants.select do |merchant|
      merchant.invoices.count > base_line
    end
  end

  def bottom_merchants_by_invoice_count
    base_line = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation*2)
    @sales_engine.all_merchants.select do |merchant|
      merchant.invoices.count < base_line
    end
  end

  def top_days_by_invoice_count
  end

  def invoice_status(status)
    ((@sales_engine.all_invoices.select do |invoice|
      invoice.status == status
    end.length / count_invoices) * 100).round(2)
  end
end
