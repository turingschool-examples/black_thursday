module StandardDeviation
  
  def sum(num_set)
    (num_set).inject(0){|accum, int| accum + int }
  end
  def mean(num_set)
   sum(num_set) / (num_set).length.to_f
  end

  def sample_variance(num_set)
    m = mean(num_set)
    sum = (num_set).inject(0){|accum, int| accum + (int - m) ** 2 }
    sum / ((num_set).length - 1).to_f
  end

  def standard_deviation(num_set)
    return Math.sqrt(sample_variance(num_set))
  end

end
