require 'bigdecimal'

module Mathable
  def stdev(set)
    Math.sqrt(sum_square_diff(set)/(set.count-1))
  end

  def sum_square_diff(set)
    set.sum do |item|
      (item - avg(set))**2
    end
  end

  def avg(set)
    BigDecimal(set.sum)/set.count
  end
end