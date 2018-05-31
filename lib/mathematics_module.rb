module Mathematics
  def calculate_average(numbers)
    added = numbers.inject(0) {|sum, number| sum + number}
    added.to_f / numbers.size.to_f
  end

  def calculate_standard_deviation(numbers)
    average = calculate_average(numbers)
    subbed = numbers.map do |number|
      (number - average) ** 2
    end
    new_mean = calculate_average(subbed)
    Math.sqrt(new_mean).round
  end
end
