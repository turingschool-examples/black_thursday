module AnalystMath

  def self.average(numbers)
    average = numbers.reduce(&:+) / numbers.length.to_f
    average.round(2)
  end

  def self.standard_deviation(numbers)
    sum_of_deviations_squared = numbers.reduce(0) do |sum, num|
      sum += (num.to_f - self.average(numbers)) ** 2
    end
    Math.sqrt(sum_of_deviations_squared / (numbers.length - 1)).round(2)
  end

  def self.std_devs_out(numbers, devs = 1)
    answer = self.average(numbers) + (self.standard_deviation(numbers) * devs)
    answer.round(2)
  end

  def self.percentage(numerator, denominator)
    (numerator.to_f / denominator * 100).round(2)
  end


end
