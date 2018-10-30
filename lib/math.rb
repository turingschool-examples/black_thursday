module Math
  
  def sum(nums)
    nums.inject(0) do |running_count, item|
      running_count + item
    end
  end

  def mean(nums)
    sum = sum(nums)
    (sum.to_f / nums.length).round(2).to_d
  end

  def std_dev(nums)
    mean = mean(nums)
    nums = nums.map do |num|
      (num - mean) * (num - mean)
    end
    nums_sum = sum(nums)
    variance = nums_sum.to_f / (nums.length - 1)
    Math.sqrt(variance).round(2)
  end
  
end