require 'bigdecimal'

class SalesAnalyst

  def initialize(merchant_repository, item_repository)
    @merchant_repository = merchant_repository
    @item_repository = item_repository
  end

  def average_items_per_merchant
    average = get_number_of_items / get_number_of_merchants.to_f
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = Math.sqrt( get_mean_of_totaled_squares )
    average.round(2)
  end

  def merchants_with_high_item_count
    hash = group_item_by_merchant_id
    array = []
    hash.each do |id, items|
      if items.count > (average_items_per_merchant_standard_deviation + average_items_per_merchant)
        array << @merchant_repository.find_by_id(id)
      end
    end
    array
  end

  def average_item_price_for_merchant(id)
    sum = BigDecimal.new(0)
    merchant = group_item_by_merchant_id.find do |key, items|
      key == id
    end
    merchant[1].each do |item|
      sum += item.unit_price
    end
    average = sum / BigDecimal.new(merchant[1].count)
    average.round(2)
  end

  def get_mean_of_totaled_squares
    get_total_of_squares / get_squared_values.count
  end

  def get_total_of_squares
    squares = get_squared_values
    squares.inject(0) do |sum, value|
      sum += value
    end
  end

  def get_squared_values
    hash = group_item_by_merchant_id
    hash.map do |id, item|
      (item.count - average_items_per_merchant) ** 2
    end
  end

  def get_number_of_merchants
    @merchant_repository.merchants.count
  end

  def get_number_of_items
    @item_repository.items.count
  end

  def group_item_by_merchant_id
    @item_repository.items.group_by do |item|
      item.merchant_id
    end
  end

end
