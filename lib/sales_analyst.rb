require_relative './sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    grouped_items = group_items_by_merchant
    merchants_total = find_number_of_merchants(grouped_items)
    items_total = find_total_number_of_items(grouped_items)
    (items_total.to_f / merchants_total).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    grouped_items = group_items_by_merchant
    ipm = items_per_merchant(grouped_items)
    v = variance(average, ipm)
    square_root_of_variance(v, ipm)
  end

  def group_items_by_merchant
    @sales_engine.items.all.group_by(&:merchant_id)
  end

  def find_number_of_merchants(grouped_items)
    grouped_items.inject(0) do |count, (id, items)|
      count + 1
    end
  end

  def find_total_number_of_items(grouped_items)
    grouped_items.inject(0) do |count, (id, items)|
      count + items.count
    end
  end

  def items_per_merchant(grouped_items)
    grouped_items.map do |id, items|
      items.count
    end
  end

  def variance(average, ipm)
    variance = ipm.inject(0) do |count, items|
      count += (items - average) ** 2
    end
  end

  def square_root_of_variance(v, ipm)
    (Math.sqrt(v/(ipm.size-1))).round(2)
  end

  def one_standard_deviation_above
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    group_items_by_merchant.find_all do |id, items|
      items.count > one_standard_deviation_above
    end
  end
#---------------ITERATION-2-STUFF------------------------#
# sales_analyst.average_invoices_per_merchant # => 10.49
  def average_invoices_per_merchant
    grouped_invoices = group_invoices_by_merchant
    merchants_total = find_number_of_merchants(grouped_invoices)
    invoices_total = find_total_number_of_invoices(grouped_invoices)
    (invoices_total.to_f / merchants_total).round(2)
  end
# sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    grouped_invoices = group_invoices_by_merchant
    ipm = invoices_per_merchant(grouped_invoices)
    v = variance(average, ipm)
    square_root_of_variance(v, ipm)
  end
  #
  def group_invoices_by_merchant
    @sales_engine.invoices.all.group_by(&:merchant_id)
  end

  def find_number_of_merchants(grouped_invoices)
    grouped_invoices.inject(0) do |count, (id, invoices)|
      count + 1
    end
  end

  def find_total_number_of_invoices(grouped_invoices)
    grouped_invoices.inject(0) do |count, (id, invoices)|
      count + invoices.count
    end
  end

  def invoices_per_merchant(grouped_invoices)
    grouped_invoices.map do |id, invoices|
      invoices.count
    end
  end

# Which merchants are more than two standard deviations above the mean?
# sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
  def two_standard_deviations_above(average_invoices_per_merchant, average_invoices_per_merchant_standard_deviation)
    average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation*2
  end

  def top_merchants_by_invoice_count
    group_items_by_merchant.find_all do |id, invoices|
      invoices.count > two_standard_deviations_above
    end
  end
end
