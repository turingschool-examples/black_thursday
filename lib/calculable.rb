# frozen_string_literal: true

# This is the calculable module
module Calculable
  def price_converter(price)
    unit_price = price.to_s
    if unit_price.length > 1 && !unit_price.include?('.')
      unit_price = unit_price.chars.insert(-3, '.').join
    end
    unit_price
  end

  def average(sum, count)
    sum / count.to_f
  end

  def deviation(items, mean_avg)
    squares = items.map { |num| (num - mean_avg) ** 2 }
    Math.sqrt(squares.sum / (items.length.to_f - 1))
  end

  def deviation_difference(dev, count, mean_avg)
    ((count - mean_avg) / dev).to_i
  end

  def percent(value, total_value)
    (value / total_value.to_f * 100).round(2)
  end
end
