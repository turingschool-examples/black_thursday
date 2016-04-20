module StandardDeviation

  def self.sum
    self.reduce(:+) { |sum, item| sum + item }
  end

  def average
    self.sum/self.length.to_f
  end

  def standard_deviation
    average = self.average
    sum_squares = self.reduce(0) do |sum, item|
      sum + (item - average)**2
    end
    result = sum_squares/(self.length - 1).to_f
    Math.sqrt(result)
  end
end
