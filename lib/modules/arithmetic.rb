module Arithmetic
  def average(collection)
    (collection.sum / collection.length.to_f).round(2)
  end

  def standard_deviation(collection)
    Math.sqrt(s_d_numerator(collection) / collection.length).round(2)
  end

  def squared_diff(number, average)
    (number - average)**2
  end

  def s_d_numerator(collection)
    collection.map {|number| squared_diff(number, average(collection))}.sum
  end
end