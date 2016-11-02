module Calculator

  def sum_of_squared_differences(set, average)
    set.reduce(0) {|sum, element| sum += ((element - average) ** 2)}
  end

  def average(set)
    if set.empty?
      0
    else
      set.reduce(0) {|sum, num| sum += num}/set.length
    end
  end

  def standard_deviation(set)
    average = average(set)
    sum = sum_of_squared_differences(set, average)
    standard_deviation = (sum / (set.length - 1)) ** 0.5
    standard_deviation.round(2)
  end

end