# frozen_string_literal: true

# Calculates Standard Deviation
class StandardDeviation
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def average
    sum = 0
    @data.each do |datum|
      sum += datum
    end
    sum / @data.length
  end

  def sum_squares_differences
    squares_of_differences = @data.map do |datum|
      (datum - average)**2
    end
    sum = 0
    squares_of_differences.each do |square|
      sum += square
    end
    sum
  end

  def calculate
    Math.sqrt(sum_squares_differences / (@data.length - 1))
  end
end
