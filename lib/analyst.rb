class Analyst

  def get_merchants
    merchant_ids = @mr.repository.map do |merchant|
      merchant.id
    end.uniq
  end

  def get_array_of_merchant_items
    array_of_merchant_items = merchant_ids.map do |id|
      @ir.find_all_by_merchant_id(id)
    end
  end

  def get_array_of_items_per_merchant_count
    items_per_merchant_count = array_of_merchant_items.map do |array|
      array.count
    end
  end

  def average_items_per_merchant
    @mean = (@ir.repository.count.to_f / @mr.repository.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    total = @items_per_merchant_count.sum
    sum_squares = @items_per_merchant_count.map { |number| square = (number - mean) ** 2}.sum
    variance = sum_squares / (@items_per_merchant_count.count - 1)
    st_dev = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    #find merchants with more than one standard_devation from average
  end

  def average_item_price_per_merchant(merchant_id)
    #find the average price of items sold by merchant
  end

  def average_average_price_per_merchant
    #add all the average price together and find average
  end

  def golden_items
    #find the average price of items(of all items)
    #find the standard_devation of the price of items 
    #find merchants more than two standard_devation away from average item price
  end

end
