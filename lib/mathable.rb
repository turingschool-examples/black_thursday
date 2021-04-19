module Mathable

  def z_score(value, average, standard_deviation)
    ((value - average) / standard_deviation).to_f
  end

  def average(value, total)
    value / total
  end

  def standard_deviation(values)
    squared_differences = values.sum do |value|
      ((value - average)**2).to_f
    end
    divided_sum = ((squared_differences) / (values.length - 1))
    square_root = ((divided_sum)**0.5).to_f
    square_root.round(2)
  end

end
