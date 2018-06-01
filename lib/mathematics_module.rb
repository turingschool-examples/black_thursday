module Mathematics
  def calculate_average(numbers)
    added = numbers.inject(0) {|sum, number| sum + number}
    (added.to_f / numbers.size.to_f).round(2)
  end

  def calculate_standard_deviation(numbers)
    average = calculate_average(numbers)
    subtracted = numbers.map do |number|
      (number - average) ** 2
    end
    sq_sum = subtracted.inject(0) {|sum, number| sum += number}
    to_be_rooted = sq_sum / (subtracted.length - 1)
    Math.sqrt(to_be_rooted).round(2)
  end
end
