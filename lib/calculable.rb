# frozen_string_literal: true

require 'time'

# This is the calcuable module
module Calculable
  def price_converter(price)
    unit_price = price.to_s
    if unit_price.length > 1 && !unit_price.include?('.')
      unit_price.chars.insert(-3, '.').join
    end
  end

  def average(sum, count)
    sum / count
  end

  def deviation(items)
    if items.length > 1
      mean_avg = (items.sum / items.length.to_f)
      items.map { |num| (num - mean_avg) ** 2 }.sum / (all_nums.length - 1)
    end
  end

  def percent(value, total_value)
    value / total_value * 100
  end
end
