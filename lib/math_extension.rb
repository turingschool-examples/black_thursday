module Math

  def self.mean(enum)
    count = enum.count

    total = enum.reduce(0) do |sum, element|
      element = yield element if block_given?
      unless element.nil?
        sum + element
      else
        count -= 1
        sum
      end
    end
    return nil if count.zero?
    total / count
  end

  def self.standard_deviation(enum, &transform)
    enum_average = mean(enum, &transform)
    count = enum.count

    sum_of_squares = enum.reduce(0) do |sum, element|
      element = yield element if block_given?
      unless element.nil?
        sum + (element - enum_average) ** 2
      else
        count -= 1
        sum
      end
    end
    sqrt(sum_of_squares / (count - 1))
  end

  def self.standard_deviations_above(x_above, enum, &transform)
    standard_dev = standard_deviation(enum, &transform)
    threshold = mean(enum, &transform) + x_above * standard_dev
    enum.select do |element|
      element = yield element if block_given?
      if x_above > 0
        element > threshold
      else
        element < threshold
      end
    end
  end

end
