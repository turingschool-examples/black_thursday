
module Statistics

  def average(collection)
    (collection.reduce(:+) / collection.count.to_f).round(2)
  end

  def standard_deviation(collection)
    numerator   = std_dev_numerator(collection)
    denominator = collection.count - 1.0
    Math.sqrt(numerator / denominator).round(2)
  end

  def squared_difference(unit, average)
    (unit - average.to_f) ** 2
  end

  def std_dev_numerator(collection)
    collection.map do |number|
      squared_difference(number, average(collection))
    end.reduce(:+).to_f
  end

  def top_threshold(collection, distance_from_average)
    average(collection) + standard_deviation(collection) * distance_from_average
  end

  def bottom_threshold(collection, distance_from_average)
    average(collection) - standard_deviation(collection) * distance_from_average
  end

end