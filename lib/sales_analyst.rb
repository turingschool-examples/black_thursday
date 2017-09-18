require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    total_items = sales_engine.items.items.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_items.to_f / total_merchants).round(2)
  end

  def counts_per_merchant(method)
    sales_engine.merchants.merchants.map do |merchant|
      method.call(merchant.id).count
    end
  end

  def mean(list)
    if list.first.class == BigDecimal
      list.reduce(BigDecimal.new("0.0"), :+) / list.count
    else
      list.reduce(0.0, :+) / list.count
    end
  end

  def standard_deviation(list)
    mean_result = mean(list)
    differences_squared = list.map { |num| (num - mean_result)**2 }
    Math.sqrt(differences_squared.sum/(differences_squared.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    counts = counts_per_merchant(sales_engine.method(:find_merchant_items))
    standard_deviation(counts)
  end

  def merchants_with_high_item_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_items))
    one_std_deviation = mean(counts) + standard_deviation(counts)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_items(merchant.id).count > one_std_deviation
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items_for_merchant = sales_engine.find_merchant_items(merchant_id)
    mean(items_for_merchant.map {|item| item.unit_price}).round(2)
  end

  def average_average_price_per_merchant
    mean(sales_engine.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end).round(2)
  end

  def item_unit_price_list
    sales_engine.items.items.map { |item| item.unit_price }
  end

  def std_deviation_of_item_price
    standard_deviation(item_unit_price_list)
  end

  def golden_items
    std_deviation = std_deviation_of_item_price
    sales_engine.items.items.select do |item|
      item.unit_price > (std_deviation * 2)
    end
  end

  def average_invoices_per_merchant
    total_invoices = sales_engine.invoices.invoices.count
    total_merchants = sales_engine.merchants.merchants.count
    (total_invoices.to_f / total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoice))
    standard_deviation(counts)
  end

  def top_merchants_by_invoice_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoice))
    two_std_deviations = mean(counts) + (standard_deviation(counts)*2)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_invoice(merchant.id).count > two_std_deviations
    end
  end

  def bottom_merchants_by_invoice_count
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoice))
    two_std_deviations = mean(counts) - (standard_deviation(counts)*2)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_invoice(merchant.id).count < two_std_deviations
    end
  end

  def merchants_above_one_standard_deviation
    counts = counts_per_merchant(sales_engine.method(:find_merchant_invoice))
    one_std_deviation = mean(counts) + standard_deviation(counts)
    sales_engine.merchants.merchants.select do |merchant|
      sales_engine.find_merchant_invoice(merchant.id).count > one_std_deviation
    end
  end

  def day_to_string(time)
    if time.sunday?
      "Sunday"
    elsif time.monday?
      "Monday"
    elsif time.tuesday?
      "Tuesday"
    elsif time.wednesday?
      "Wednesday"
    elsif time.thursday?
      "Thursday"
    elsif time.friday?
      "Friday"
    elsif time.saturday?
      "Saturday"
    end
  end

  def create_invoice_days
    sales_engine.invoices.invoices.group_by do |invoice|
      day_to_string(invoice.created_at)
    end
  end

  def create_day_count
    day_counts = []
    invoice_days = create_invoice_days
    day_counts << invoice_days["Sunday"].count
    day_counts << invoice_days["Monday"].count
    day_counts << invoice_days["Tuesday"].count
    day_counts << invoice_days["Wednesday"].count
    day_counts << invoice_days["Thursday"].count
    day_counts << invoice_days["Friday"].count
    day_counts << invoice_days["Saturday"].count
    day_counts
  end

  def top_days_by_invoice_count
    invoice_days = create_invoice_days
    day_count = create_day_count
    mean_counts = mean(day_count)
    std_deviation = standard_deviation(day_count)
    invoice_days.select do |days, invoices|
      invoices.count > (std_deviation + mean_counts)
    end.keys
  end

  def invoice_status(status)
    all = sales_engine.invoices.all.count
    status_list = sales_engine.invoices.find_all_by_status(status).count
    (status_list.to_f / all * 100).round(2)
  end
end
