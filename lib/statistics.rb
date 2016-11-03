module Statistics

  def standard_deviation(array1, array2 = array1, average)
    numerator   = std_dev_numerator(array1, average)
    denominator = std_dev_denominator(array2)
    Math.sqrt(numerator / denominator).round(2)
  end

  def squared_distance_from_average(unit, average)
    (unit - average.to_f) ** 2
  end

  def std_dev_numerator(array, average)
    array.map do |number|
      squared_distance_from_average(number, average)
    end.reduce(:+)
  end

  def std_dev_denominator(array)
    array.count - 1.0
  end

end