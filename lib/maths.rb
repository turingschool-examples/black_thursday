module Maths

  def square(number)
    number ** 2
  end

  def double(number)
    number * 2
  end

  def sum(number_array)
    number_array.reduce(0.0) { |total, number| total += number}
  end

  def mean(number_array)
    BigDecimal.new(((sum(number_array) / number_array.length)).round(2), 10)
  end

  def deviation(number, mean)
    number - mean
  end

  def percent(number, total)
    ((number / total.to_f) * 100).round(2)
  end

  def square_deviation(number, mean)
    square(deviation(number, mean))
  end

  def variance_numerator(number_array)
    sum(number_array.map { |number| square(deviation(number, mean(number_array))) })
  end

  def variance(number_array)
    (variance_numerator(number_array) / (number_array.length - 1))
  end

  def standard_deviation(number_array)
    Math.sqrt(variance(number_array)).round(2)
  end

  def outlier?(number, mean, standard_deviation, deviations)
    if deviations < 0
      number < sum([mean, standard_deviation * deviations])
    else
      number > sum([mean, standard_deviation * deviations])
    end
  end
end
