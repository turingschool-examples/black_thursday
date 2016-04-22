module StandardDeviation

  def sum(array)
    array.reduce(0) { |sum, item| sum + item }
  end

  def average(array)
    sum(array)/array.length.to_f
  end

  def standard_deviation(array)
    result = array.reduce(0) do |sum, item|
      sum + (item - average(array))**2
    end/(array.length - 1).to_f
    Math.sqrt(result).round(2)
  end

  def threshold(array, num_std_devs)
    (average(array) + num_std_devs * standard_deviation(array)).round(2)
  end

end
