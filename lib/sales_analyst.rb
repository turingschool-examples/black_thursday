

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant_count = @sales_engine.merchants.all.count
    item_count = @sales_engine.items.all.count
    (item_count.to_f/ merchant_count).round(2)
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

  def merchants_with_high_item_count
    filter_merchants_by_items_in_stock.map do |merchants|
    @sales_engine.merchants.find_by_id(merchants[0])
    end
  end


  def average_item_price_for_merchant(merchant_id)
    list = find_the_collections_of_items(merchant_id.to_s)
    list.reduce(0) { |sum, item|
      sum + item.unit_price } / list.count
  end

  def find_the_collections_of_items(merchant_id)
    @sales_engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_average_price_per_merchant
    merchant_list.reduce(0) { |sum, merchant|
      sum + average_item_price_for_merchant(merchant)
      } / merchant_list.count
  end

  def average_unit_price
    @sales_engine.items.all.reduce(0) { |sum, item|
    sum + item.unit_price
     } / @sales_engine.items.all.count
  end

  def unit_price_and_average_difference_squared_sum
    @sales_engine.items.all.reduce(0) { |sum, item|
    sum += (item.unit_price - average_unit_price) ** 2 }
  end

  def unit_price_squared_sum_division
    unit_price_and_average_difference_squared_sum / ((@sales_engine.items.all.count) - 1)
  end

  def unit_price_standard_deviation
    Math.sqrt(unit_price_squared_sum_division).round(2)
  end


end
