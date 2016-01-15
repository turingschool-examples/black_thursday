class SalesAnalyst
attr_reader :sales_engine, :items, :merchants, :invoices

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = sales_engine.items
    @merchants = sales_engine.merchants
    @invoices = sales_engine.invoices
  end

  def total_merchants
    merchants.all.count.to_f
  end

  def total_items
    items.all.count.to_f
  end

  def total_invoices
    invoices.all.count.to_f
  end

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def variance_of_average_and_items
    avg = average_items_per_merchant
    merchants.all.map { |merchant| (merchant.items.count - avg) **2 }.inject(:+)
  end

  def variance_divided_merchants
    variances = variance_of_average_and_items
    variances/(total_merchants - 1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(variance_divided_merchants).round(2)
  end

  def merchants_with_low_item_count
    sd = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    merchants.all.map { |merchant| merchant if merchant.items.count <= avg-sd }.compact
  end

  def average_item_price_for_merchant(merchant_id)
    found_items = items.find_all_by_merchant_id(merchant_id)
    count = found_items.count
    (found_items.reduce(0) { |sum, item| item.unit_price + sum }/count).round(2)
  end


  def average_price_per_merchant
    (merchants.all.map { |merchant| average_item_price_for_merchant(merchant.id) }.inject(:+)/total_merchants).round(2)
  end

  def average_price_of_all_items
    (items.all.reduce(0) { |sum, item| item.unit_price + sum}/total_items).to_f.round(2)
  end

  def variance_of_all_item_prices_from_mean
    avg = average_price_of_all_items
    (items.all.map { |item| (item.unit_price.to_f - avg) ** 2 }.inject(:+)).round(2)
  end

  def variance_divide_total_items
    variance = variance_of_all_item_prices_from_mean
    (variance/(total_items - 1)).round(2)
  end

  # def standard_deviation(something)
  #   Math.sqrt(something).round(2)
  # end
  def items_standard_deviation
    Math.sqrt(variance_divide_total_items).round(2)
  end

  def golden_items
    sd = items_standard_deviation
    avg = average_price_of_all_items
    items.all.map { |item| item if item.unit_price >= (avg + (sd*2)) }.compact
  end

  def average_invoices_per_merchant
    (total_invoices/total_merchants).round(2)
  end

  def total_invoices_with_common_status(status)
    invoices.all.map { |invoice| invoice if invoice.status == status }.compact.count
  end

  def invoice_status(status)
    ((total_invoices_with_common_status(status)/total_invoices) * 100).round(1) 
  end
end
