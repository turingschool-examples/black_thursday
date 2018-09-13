require 'bigdecimal'

module PrecisionMath
  def convert_to_big_d(num)
    return num if num.class == BigDecimal
    BigDecimal.new(num.to_f, num.to_s.length)
  end

  def convert_array_to_big_d(nums)
    return nums if nums.all? {|num| num.class == BigDecimal}
    nums.map do |num|
      convert_to_big_d(num)
    end
  end

  def stdev(nums)
    nums = convert_array_to_big_d(nums)
    mean = average(nums)
    differences = nums.map do |value|
      (value - mean)**2
    end
    (add(differences) / (nums.length - 1))**(0.5)
  end

  def average(nums)
    nums = convert_array_to_big_d(nums)
    sum = add(nums)
    sum / nums.length
  end

  def add(nums)
    nums = convert_array_to_big_d(nums)
    nums.inject(0.0){|sum, num| sum += num}
  end
end
