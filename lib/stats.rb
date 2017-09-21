module Stats

  def self.mean(enum)
    elements_used = enum.count

    total = enum.reduce(0) do |sum, element|
      element = yield element if block_given?
      unless element.nil?
        sum + element
      else
        elements_used -= 1
        sum
      end
    end

    return nil if elements_used.zero?
    total / elements_used.to_f
  end

  def self.standard_deviation(enum, &transform)
    average = mean(enum, &transform)
    elements_used = enum.count - 1

    sum_of_squares = enum.reduce(0) do |sum, element|
      element = yield element if block_given?
      unless element.nil?
        sum + (element - average) ** 2
      else
        elements_used -= 1
        sum
      end
    end

    return nil if elements_used.zero?
    Math.sqrt(sum_of_squares / elements_used.to_f)
  end

  def self.standard_deviations_from_mean(x_above, enum, &transform)
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
