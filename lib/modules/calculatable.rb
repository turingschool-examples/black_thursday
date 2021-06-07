module Calculatable
  def average_mean(numerator, denominator)
    (numerator / denominator.to_f).round(2)
  end

  def average_standard_deviation
    numerator = items_by_merch_count.sum do |num|
      (num - average_items_per_merchant) ** 2
    end
    denominator = (items_by_merch_count.length - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end
end
