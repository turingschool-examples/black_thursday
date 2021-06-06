require 'CSV'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average(data)
    data.sum / data.size
  end

  def standard_deviation(sample_size)
    mean = sample_size.sum / sample_size.size.to_r
    sample_size.map do |sample|
      (sample - mean) ** 2 / (sample_size.size - 1)
    end.round(2)

  end

  def average_items_per_merchant(merchant_id)
  end

  def average_items_per_merchant_standard_deviation(merchant_id)
  end
  # def mean
  #   mean_array = 0
  #   @numbers.each do |number|
  #     mean_array += number
  #   end
  #   mean_array
  #   mean = mean_array.to_f / @numbers.length
  # end
  #
  # def standard_deviation
  #   Math.sqrt(@numbers.sum do |number|
  #    ((number - mean) ** 2) / (@numbers.size - 1)
  #   end).round(2)
  # end
end
