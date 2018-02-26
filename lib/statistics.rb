module Statistics
  def average(data_set, count)
    data_set.inject { |sum, num| sum + num }.to_f / count
  end

  def stdev(data_set, average)
    dif = data_set.map { |num| (num - average)**2 }
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (data_set.length - 1))
  end
end
