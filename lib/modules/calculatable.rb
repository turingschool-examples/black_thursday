module Calculatable
  def average_mean(numerator, denominator)
    (numerator / denominator.to_f).round(2)
  end

  def average_standard_deviation(set, average)
    numerator = set.sum do |num|
      (num - average) ** 2
    end
    denominator = (set.length - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end
end
