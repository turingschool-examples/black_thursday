module Statistics

  def stdev(array)
    average     = find_average(array)
    numerator   = array.map{ |number| (number - average).to_f ** 2 }
    variance    = numerator.reduce(:+) / array.count
    Math.sqrt(variance) 
  end

  def find_average(array)
    array.inject{ |sum, el| sum + el}.to_f / array.count
  end

  def in_or_out_stdev(array)
    stdev(array) + find_average(array) 
  end

end