module StandardDeviation

  def average(info)
    (info.inject(:+) / info.count.to_f).round(2)
  end

  def variance(info)
    current_average = average(info)
    info.map {|number| (current_average - number) ** 2}
  end

  def standard_deviation(info)
    v = variance(info)
    Math.sqrt(average(v)).round(2)
  end

end
