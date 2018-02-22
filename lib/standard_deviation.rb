# frozen_string_literal: true

# Calculates Standard Deviation
class StandardDeviation
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def average
    sum = @data.reduce(:+)
    sum / @data.length.to_f
  end

  def sum_squares_differences
    squares_of_differences = @data.map do |datum|
      (datum - average)**2
    end
    squares_of_differences.reduce(:+)
  end

  def calculate
    Math.sqrt(sum_squares_differences / (@data.length - 1))
  end

  def self.calculate(data)
    calculator = new data
    calculator.calculate
  end
end
