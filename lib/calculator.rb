module Calculator
  def standard_deviation(numbers, average)
    difference = difference(numbers, average)
    squared = square(difference)
    sum = squared.sum
    num_minus_one = squared.length - 1
    variance = sum / num_minus_one
    Math.sqrt(variance).round(2)
  end

  def difference(items_per_merchant, average)
    items_per_merchant.map do |item|
      item - average
    end
  end

  def average(array_of_numbers)
    return 0 if array_of_numbers.empty?
    sum = array_of_numbers.sum
    sum = BigDecimal(sum)
    length = BigDecimal(array_of_numbers.length)
    BigDecimal(sum / length)
  end

  def square(difference)
    difference.map do |index|
      (index ** 2)
    end
  end

  def divide(difference)
    num_minus_one = difference.length - 1
  end
    
  def by_deviation(number, average, std, deviations)
    if deviations < 0
      number < (average + (std * deviations))
    else
      number > (average + (std * deviations))
    end
  end
end