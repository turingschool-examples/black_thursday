module StandardDeviation

  def sum
    self.reduce(:+) { |sum, item| sum + item }
  end

  def average
    self.sum/self.length.to_f
  end

  def standard_deviation
    average = self.average
    self.reduce(0) do |sum, item|
      sum + (item - average)**2
  end
end
