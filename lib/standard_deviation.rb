module StandardDeviation
  def sum(array)
    array.reduce(0) do |sum, number|
      sum += number
      sum
    end
  end

  def mean(array)
    sum(array) / array.length.to_f
  end

  def squared_differences_sum(array)
    array.reduce(0) do |result, number|
      result += (mean(array) - number) ** 2
      result
    end
  end

  def standard_deviation(array)
    Math.sqrt(squared_differences_sum(array)/ (array.length - 1).to_f)
  end

  def above_standard_deviation(array, standard_deviations)
    cutoff = mean(array) + (standard_deviations *standard_deviation(array))
    array.find_all do |number|
      number >= cutoff
    end
  end

  def below_standard_deviation(array, standard_deviations)
    cutoff = mean(array) - (standard_deviations *standard_deviation(array))
    array.find_all do |number|
      number <= cutoff
    end
  end
end