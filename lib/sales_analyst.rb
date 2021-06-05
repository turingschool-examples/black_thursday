require 'CSV'
class SalesAnalyst
  attr_reader :numbers, :engine

  def initialize(numbers, engine)
    @numbers = numbers
    @engine = engine
  end

  def mean
    mean_array = 0
    @numbers.each do |number|
      mean_array += number
    end
    mean_array
    mean = mean_array.to_f / @numbers.length
  end
end
