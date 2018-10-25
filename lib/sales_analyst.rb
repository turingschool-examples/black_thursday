class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_repo = sales_engine.items
    @merchant_repo = sales_engine.merchants
  end

  def num_items_for_each_merchant
    items_per_merchant = {}
    @merchant_repo.all.each do |merchant|
      items_per_merchant[merchant] =
          @item_repo.find_all_by_merchant_id(merchant.id).size
    end
    items_per_merchant
  end

  def count_of_merchants
    @merchant_repo.all.size
  end

  def average_items_per_merchant
    items = num_items_for_each_merchant.values
    (sum(items).to_f / count_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = num_items_for_each_merchant.values
    std_dev(items_per_merchant)
  end

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
  
  def merchants_with_high_item_count
    one_std_dev = average_items_per_merchant +
                  average_items_per_merchant_standard_deviation
    high_item_counts = []
    num_items_for_each_merchant.each do |merchant, item_count|
      high_item_counts << merchant if item_count > one_std_dev
    end
    high_item_counts
  end

  # maths

  def sum(nums)
    nums.inject(0) do |running_count, item|
      running_count + item
    end
  end

  def mean(nums)
    ar_sum = nums.inject(0) do |running_count, item|
      running_count + item
    end
    avg = ar_sum.to_f / nums.length
  end

  def std_dev(nums)
    mean = mean(nums)
    nums = nums.map do |num|
      (num - mean) * (num - mean)
    end
    nums_sum = sum(nums)
    variance = nums_sum.to_f / (nums.length - 1)
    deviation = Math.sqrt(variance).round(2)
  end


end
