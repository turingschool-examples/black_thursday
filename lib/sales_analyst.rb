class SalesAnalyst
  attr_reader :merchant_repo,
              :item_repo

  def initialize(merchant_repo, item_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
  end

  def average_items_per_merchant
    average = @item_repo.items.count / @merchant_repo.merchants.count.to_f
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = @item_repo.items.each_with_object(Hash.new(0)) do |merchant, counts|
      counts[merchant.merchant_id] += 1
    end

    items_per_merchant_array = []
    items_per_merchant.each do |key, value|
      items_per_merchant_array << value
    end

    squared = items_per_merchant_array.map do |number|
      (number - average_items_per_merchant) ** 2
    end

    sum = squared.inject(0) do |sum, number|
      sum + number
    end

    divided = (sum / squared.count)
    Math.sqrt(divided).round(2)
  end

end
