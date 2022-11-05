module StandardDeviation

  def diff_and_square(amounts)
    amounts.map do |amount|
      (amount - average_items_per_merchant)**2
    end
  end

  def diff_and_square_sum(amounts)
    diff_and_square(amounts).sum
  end

  def divide_diff_and_square_sum(amounts)
    diff_and_square_sum(amounts) / (amounts.length - 1)
  end

  def standard_deviation(amounts)
    Math.sqrt(divide_diff_and_square_sum(amounts)).round(2)
  end
end
