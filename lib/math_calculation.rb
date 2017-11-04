module MathCalculation

  def average(numbers)
    numbers.sum.to_f / numbers.count
  end

  def standard_deviation(numbers, average = average(numbers))
    num = numbers.map do |number|
      (number - average) ** 2
    end.sum
    Math.sqrt(num / (numbers.count - 1)).round(2)
  end


end
