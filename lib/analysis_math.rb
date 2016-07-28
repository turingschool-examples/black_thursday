require 'bigdecimal'
module AnalysisMath

  def sum(numbers)
    BigDecimal(numbers.reduce(:+),6)
  end

  def mean(numbers)
    sum(numbers)/numbers.count
  end

  def variance(numbers)
    mean = mean(numbers)
    degrees_of_freedom = numbers.count - 1
    sum_of_squares = numbers.reduce(0) do |result, num|
      result += (num-mean)**2
      result
    end
    sum_of_squares / degrees_of_freedom
  end

  def standard_deviation(numbers)
    Math.sqrt(variance(numbers)).round(2)
  end

end
