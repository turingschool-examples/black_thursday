module Statistics

  def standard_deviation(collection)
    numerator   = std_dev_numerator(collection)
    denominator = collection.count - 1.0
    Math.sqrt(numerator / denominator).round(2)
  end

  def average(collection)
    (collection.reduce(:+) / collection.count.to_f).round(2)
  end

  def squared_distance_from_average(unit, average)
    (unit - average.to_f) ** 2
  end

  def std_dev_numerator(collection)
    collection.map do |number|
      squared_distance_from_average(number, average(collection))
    end.reduce(:+).to_f
  end

  def std_dev_denominator(collection)
    collection.count - 1.0
  end

  def compare_with_std_dev(collection, direction, quantity = 1)
    mean = average(collection)
    std_dev = standard_deviation(collection) * quantity
    #  return
    collection.find_all do |unit|
      unit < (average - (standard_deviation * 2))
    end
  end

end