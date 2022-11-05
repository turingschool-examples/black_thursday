module StandardDeviation
  def diff_and_square(amounts, average)
    amounts.map do |amount|
      (amount - average)**2
    end
  end

  def diff_and_square_sum(amounts, average)
    diff_and_square(amounts, average).sum
  end

  def divide_diff_and_square_sum(amounts, average)
    diff_and_square_sum(amounts, average) / (amounts.length - 1)
  end

  def standard_deviation(amounts, average)
    Math.sqrt(divide_diff_and_square_sum(amounts, average)).round(2)
  end
end
