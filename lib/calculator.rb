require 'pry'
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
    #refactor me
    avg = average(set)
    sum = set.map do |item_count|
      (item_count - avg) ** 2
    end.reduce(:+)
    ((sum / (set.length - 1)) ** 0.5).round(2)
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