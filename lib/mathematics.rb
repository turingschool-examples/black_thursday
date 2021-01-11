module Mathematics

  def find_average
    (@items.item_list.count.to_f / @merchants.merchant_list.count.to_f).round(2)
  end

  def standard_deviation
    total_count = @merchants.merchant_list.reduce([]) do |acc, merchant|
      acc << merchant.item_name.count
      acc
    end

    sum = total_count.sum do |value|
      ((value - find_average)**2)
    end
    result = (sum / (476 - 1))

    Math.sqrt(result).round(2)
  end

  def find_merchants_with_most_items
    total_count = @merchants.merchant_list.reduce({}) do |acc, merchant|
      acc[merchant] = merchant.item_name.count
      acc
    end

    total_count.select do |key, value|
      value >= 7
    end
  end
end
