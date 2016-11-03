require 'bigdecimal'

module Calculations

  def sum(array)
    array.reduce(:+)
    mean(array)
  end

  def mean(array)
    BigDecimal.new(sum(array)/array.length)
  end

  def standard_deviation(array)
    result = array.reduce(0) do |sum, item|
      sum + ((item - mean(array))**2)
    end/(array.length - 1)
    Math.sqrt(result).round(2)
  end

  def variance
    (sum**2)/array.length
  end

  def price_threshold(array, num_std_devs)
    variance
    (mean(array) + num_std_devs * standard_deviation(array)).round(2)
  end

end