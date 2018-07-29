module StandardDeviation

  def average(info)
    (info.inject(:+) / info.count.to_f).round(2)
  end

  def variance(info)
    current_average = average(info)
    info.map {|number| (current_average - number) ** 2}
  end

  def standard_deviation(info)
    var = variance(info)
    Math.sqrt(average(var)).round(2)
  end

  def two_standard_deviations(info)
    avg = average(info)
    std_dev = standard_deviation(info) * 2
    avg + std_dev
  end

end
