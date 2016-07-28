module StandardDeviation
  include Math

  def standard_deviation(set)
    total_of_squares = sum_squares(set, mean(set))
    sqrt(total_of_squares / (set.length - 1))
  end

  def sum_squares(set, mean)
    set.reduce(0) do |total, item|
      total += (find_difference_from_mean(item, mean) ** 2)
      total
    end
  end

  def mean(set)
    set.reduce(:+) / set.length.to_f
  end

  def find_difference_from_mean(item, mean)
    (item - mean).abs.to_f
  end

end
