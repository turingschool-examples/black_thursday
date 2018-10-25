module Statistics
  def standard_deviation(number_set)
    mean = find_mean(number_set)
    step_1 = number_set.map { |num| ((num - mean) ** 2) }
    step_2 = step_1.inject(0) { |sum, n| sum + n }
    step_3 = number_set.length - 1
    step_4 = step_2 / step_3
    Math.sqrt(step_4).round(2)
  end

  def find_mean(number_set)
    number_set.inject(0) { |sum, n| sum + n } / number_set.length.to_f
  end
end
