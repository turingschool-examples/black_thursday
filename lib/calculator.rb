module Calculator

  def average(set)
    (set.reduce(0) { |sum, num| sum + num } / set.length.to_f).round(2)
  end

  def sum_of_squared_differences(set, average)
    set.reduce(0) { |sum, num| sum + (num - average)**2 }
  end

  def std_dev(set)
    average = average(set)
    sum = sum_of_squared_differences(set, average)
    ((sum / (set.length - 1)) ** 0.5).round(2)
  end
end
