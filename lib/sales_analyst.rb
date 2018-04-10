require_relative '../lib/sales_engine'
# Sales Analyst class for analyzing data
class SalesAnalyst
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    merch_count = @engine.merchants.all.count
    item_count = @engine.items.all.count
    (item_count / merch_count).to_f.round(2)
  end

  def items_per_merchant
    items_by_merch = @engine.items.all.group_by(&:merchant_id)

    items_by_merch.each_key do |key|
      items_by_merch[key] = items_by_merch[key].length
    end
  end

  def average_items_per_merchant_standard_deviation
    ipm = items_per_merchant.values.sort
    avg = average_items_per_merchant
    array = ipm.map do |items_per_merch|
      (items_per_merch - avg)**2
    end

    variance = array.inject(0) do |sum, num|
      sum + num
    end

    std_dev = variance / (array.count - 1)
    Math.sqrt(std_dev).to_f.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    items_per_merchant.map do |id, num_of_items|
      if num_of_items >= avg + std_dev
        result = @engine.merchants.find_by_id(id)
      end
      result
    end.compact
  end
end
