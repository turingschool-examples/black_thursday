module Statistics

  def stdev(array)
    numerator   = array.map{ |number| (number - find_average(array)).to_f ** 2 }
    variance    = numerator.reduce(:+) / array.count
    Math.sqrt(variance)
  end

  def find_average(array)
    array.inject{ |sum, number| sum + number}.to_f / array.count
  end
end