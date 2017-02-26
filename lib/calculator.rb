require 'pry'
module Calculator
  
  def average(set)
    if set.empty?
      0
    else
      (set.reduce(:+) / set.length).round(2)
    end
  end

  def standard_deviation(set)
    #refactor me, calculates average every time
    sum = set.map do |item_count|
      (item_count - average(set)) ** 2
    end.reduce(:+)
    ((sum / (set.length - 1)) ** 0.5).round(2)
  end

  def one_standard_deviation_above_mean(set)
    average(set) + (standard_deviation(set))
  end

  def two_standard_deviations_above_mean(set)
    average(set) + ((standard_deviation(set) * 2))
  end

end