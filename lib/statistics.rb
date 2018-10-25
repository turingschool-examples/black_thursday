module Statistics
  def standard_deviation(number_set)
    mean = find_mean(number_set)
  end

  def find_mean(number_set)
    number_set.reduce
  end
  
end
