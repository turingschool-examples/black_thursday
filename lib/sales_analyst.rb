

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant_count = @sales_engine.merchants.all.count
    item_count = @sales_engine.items.all.count
    (item_count.to_f/ merchant_count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant - (each merchant's number of item')
  end

  def merchant_list
    @sales_engine.merchants.merchants.map do |merchant|
      merchant.id
    end
  end

  def find_items
    merchant_list.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant).count
    end
  end

  def find_standard_deviation_difference_total
    find_items.map do |item_total|
      (item_total - average_items_per_merchant) ** 2
    end.sum
  end

  def find_standard_deviation_total
    find_standard_deviation_difference_total / total_merchants_minus_one
  end

  def total_merchants_minus_one
    ((@sales_engine.merchants.all.count) -1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(find_standard_deviation_total).round(2)
  end

  def create_merchant_id_item_total_list
    Hash[merchant_list.zip find_items]
  end

  def standard_deviation_plus_average
    average_items_per_merchant_standard_deviation + average_items_per_merchant
  end

  def filter_merchants_by_items_in_stock
    create_merchant_id_item_total_list.find_all do |key, value|
      value >= 7
    end
  end


end
