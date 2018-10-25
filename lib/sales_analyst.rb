class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine # maybe inheritance instead? let's change it.............
    @item_repo = sales_engine.items
    @merchant_repo = sales_engine.merchants
  end

  def num_items_for_each_merchant
    @merchant_repo.all.map do |merchant|
      @item_repo.find_all_by_merchant_id(merchant.id).size
    end
  end

  def count_of_merchants
    @merchant_repo.all.size
  end


  def average_items_per_merchant
    items = num_items_for_each_merchant
    sum(items).to_f / count_of_merchants
  end


  # def merchants_with_high_item_count
  #
  # end

  def average_item_price_for_merchant(id)
    list = @item_repo.find_all_by_merchant_id(id)
    total = 0
    count = 0
    list.each do |item|
      item.unit_price += total
      count += 1
    end
    total / count
  end

  def sum(array)
    array.inject(0) do |things, stuff|
      things + stuff
    end
  end

  def mean(array)
    ar_sum = array.inject(0) do |things, stuff|
      things + stuff
    end

    avg = ar_sum.to_f / array.length
  end

  def std_dev(array)
    mean = mean(array)

    array = array.map do |num|
      (num - mean) * (num - mean)
    end

    array_sum = sum(array)

    variance = array_sum.to_f / (array.length - 1)

    deviation = Math.sqrt(variance).round(2)

  end


end
