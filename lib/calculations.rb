module Calculations

  def variance(mean, totals)
    totals.reduce(0) do |result, total|
      result += (total - mean) ** 2
    end
  end

  def standard_dev(variance, totals)
    (Math.sqrt(variance/totals)).round(2)
  end

end
