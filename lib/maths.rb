module Maths

  def square(number)
    number ** 2.to_d
  end

  def sum(number_array)
    summed = 0
    number_array.each do |number|
      summed += number
    end
    summed
  end

  def mean(number_array)
    BigDecimal.new((sum(number_array)) / number_array.length)
  end

  def percent(number, total)
    ((number / total) * 100)
  end

  def subtract_mean(array)
    avg = mean(array)
    array.map do |number|
      number - avg
    end
  end

  def squares(number_array)
    number_array.map do |number|
      number ** 2
    end
  end

  def sample(array_in)
    sum(array_in) / (array_in.length - 1)
  end

  def standard_deviation(array_in)
    mean_subtracted = subtract_mean(array_in)
    meansubs_squared = squares(mean_subtracted)
    sampled = sample(meansubs_squared)
    Math.sqrt(sampled).round(2)
  end

end
