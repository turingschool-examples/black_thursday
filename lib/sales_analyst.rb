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
    items_by_merch = @engine.items.all.group_by do |item|
      item.merchant_id
    end

    items_by_merch.each_key do |key|
      items_by_merch[key] = items_by_merch[key].length
    end
  end

  def average_items_per_merchant_standard_deviation
  # def std_dev(ary)
  #   mean = ary.inject(:+).to_f / ary.size
  #   Math.sqrt(ary.inject(0){|sum,val| sum + (val - mean)**2} / ary.size)
  # end
    array = @engine.merchants.all.count
    #array needs to be items_per_merchant

    avg = average_items_per_merchant
    variance = array.inject(0) do |variance, x|
      variance += (x - avg) ** 2
    end
    return avg, Math.sqrt(variance/(array.size-1))
  end
end
