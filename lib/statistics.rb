module Statistics
  def average(data_set, count)
    data_set.reduce(:+).to_f / count
  end

  def stdev(data_set, average)
    dif = data_set.map { |num| (num - average)**2 }
    added = dif.reduce(:+).to_f
    Math.sqrt(added / (data_set.length - 1))
  end
end
