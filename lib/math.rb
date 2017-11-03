module Math

  def mean(list)
    if list.first.class == BigDecimal
      list.reduce(BigDecimal.new("0.0"), :+) / list.count
    else
      list.reduce(0.0, :+) / list.count
    end
  end

  def standard_deviation(list)
    mean_result = mean(list)
    diff_squared = list.map { |num| (num = mean_result)**2 }
    Math.sqrt(diff_squared.sum/(diff_squared.count-1)).round(2)
  end

end
