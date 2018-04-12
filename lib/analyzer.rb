require 'bigdecimal'

module Analyzer
  def average(sum, total_elements)
    (BigDecimal(sum) / BigDecimal(total_elements)).round(2).to_f
  end

  def standard_deviation(set, mean)
    mean_difference_squared = set.inject(0) do |sum, number_in_set|
      sum + ((number_in_set - mean)**2)
    end
    Math.sqrt(mean_difference_squared / (set.count - 1)).round(2).to_f
  end
end
