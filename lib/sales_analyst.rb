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

end
