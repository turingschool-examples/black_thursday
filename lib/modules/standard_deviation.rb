module StandardDeviation
  def stdev(nums)
    mean = average(nums)
    differences = nums.map do |value|
      (value - mean)**2
    end
    Math.sqrt(add(differences) / (nums.length - 1))
  end

  def average(nums)
    sum = add(nums)
    sum.to_f / nums.length.to_f
  end
  
  def add(nums)
    nums.inject(0.0){|sum, num| sum += num.to_f}
  end

end
