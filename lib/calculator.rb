require 'pry'
module Calculator

  def sum(array)
    array.reduce(:+)
  end

  def mean(array)
    sum(array) / array.count
  end

  def difference(array)
    results = []
    array.each do |number|
      diff = (number - mean(array)) ** 2
      results << diff
    end
    results
  end

  def standard_deviance(array)
    difference_array = difference(array)
    total_difference = sum(difference_array)
    average_difference = total_difference / (array.count - 1)
    Math.sqrt(average_difference).round(2)
  end

end
