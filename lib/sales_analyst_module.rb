module SalesAnalystModule

  def calculate_std_dev
    sum = find_items_per_merchant.reduce(0) do |result, merchant|
      squared_difference = (average_items_per_merchant - merchant) ** 2
      result + squared_difference
    end
    Math.sqrt(sum / (total_merchants-1)).round(2)
  end

end
