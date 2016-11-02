module Calculator

  def average(set)
    if set.empty?
      0
    else
      set.reduce(0) {|sum, num| sum += num}/set.length
    end
  end

  def sum_of_squared_differences(set, average)
    set.reduce(0) {|sum, element| sum += ((element - average) ** 2)}
  end

  def standard_deviation(set)
    if set.length == 1
      0
    else
      average = average(set)
      sum = sum_of_squared_differences(set, average)
      ((sum / (set.length - 1)) ** 0.5)
    end
  end

end