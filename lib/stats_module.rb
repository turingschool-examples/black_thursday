module Stats

  def mean_value(numbers)
    sum = 0
    count = numbers.count
    numbers.each { |n| sum += n }
    (sum / count.to_f).round(2)
  end

  def difference_squared(n1, n2)
    (n1 - n2)**2
  end

  def standard_dev(numbers)
    sum = 0
    mean = mean_value(numbers)
    numbers.each { |n| sum += difference_squared(n, mean) }
    (sum / (numbers.count - 1))**0.5
  end

end
