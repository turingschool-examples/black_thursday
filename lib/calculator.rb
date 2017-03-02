require_relative 'helper'

module Calculator
  
  def percentage(count, total)
    ((count.to_f / total) * 100).round(2)
  end

  def average(set)
    if set.empty?
      0
    else
      (set.reduce(:+) / set.length).round(2)
    end
  end

  def standard_deviation(set)
    avg = average(set)
    std_sum = set.reduce(0) do |sum, item_count|
      sum + (item_count - avg) ** 2
    end
    ((std_sum / (set.length - 1)) ** 0.5).round(2)
  end

  def one_standard_deviation_above_mean(set)
    average(set) + (standard_deviation(set))
  end

  def two_standard_deviations_above_mean(set)
    average(set) + (standard_deviation(set) * 2)
  end

  def two_standard_deviations_below_mean(set)
    (average(set) - (standard_deviation(set) * 2)).round(2)
  end
end