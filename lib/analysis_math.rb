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
    numbers.inject(0) do |result, num|
      result + (num-mean)**2
    end/(numbers.count - 1)
  end

  def standard_deviation(numbers)
    BigDecimal(Math.sqrt(variance(numbers)),6)
  end

end
