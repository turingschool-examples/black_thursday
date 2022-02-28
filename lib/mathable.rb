module Mathable

  def average(sum, count)
    (sum / count).round(2)
  end

  def standard_devation(array, mean)
    sum_squares = array.map { |number| (number - mean) ** 2}.sum
    variance = sum_squares / (array.count - 1)
    st_dev = Math.sqrt(variance).round(2)
    return st_dev
  end

end
