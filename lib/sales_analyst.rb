require_relative "sales_engine"

class SalesAnalyst
  attr_reader :sales_engine, :stand_dev

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @stand_dev = average_items_per_merchant_standard_deviation
  end

  def average_items_per_merchant
    merchants = sales_engine.merchants.all.length
    items = sales_engine.items.all.length
    (items.to_f / merchants.to_f).round(2)
  end

  def merchant_list
    sales_engine.merchants.merchants.map { |merchant| merchant.id }
  end

  def find_items
    merchant_list.map do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant).count
    end
  end

  def find_standard_dev_difference_total
    find_items.map do |item_total|
      (item_total - average_items_per_merchant) ** 2
    end.sum.round(2)
  end

  def total_std_dev_sum_minus_one
    find_standard_dev_difference_total / (merchant_list.count - 1)
  end

  def average_items_per_merchant_standard_deviation
    (Math.sqrt(total_std_dev_sum_minus_one).round(2))
  end

  def merchants_by_item_count
    Hash[merchant_list.zip(find_items)] 
  end

  def standard_dev_plus_average
    @stand_dev + average_items_per_merchant
  end

  def merchants_by_items_in_stock
    merchants_by_item_count.find_all do |_, value|
      value >= standard_dev_plus_average
    end
  end

  def merchants_with_high_item_count
    merchants_by_items_in_stock.map do |merchant|
      sales_engine.merchants.find_by_id(merchant[0])
    end    
  end

  def average_item_price_for_merchant(merchant_id)
    
  end

end
































