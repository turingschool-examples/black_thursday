# frozen_string_literal: true

# This is the calculable module
module Calculable
  def self.price_converter(price)
    unit_price = price.to_s
    if unit_price.length > 1 && !unit_price.include?('.')
      unit_price = unit_price.chars.insert(-3, '.').join
    end
    unit_price
  end

  def self.average(sum, count)
    sum / count.to_f
  end

  def self.deviation(items)
    if items.length > 1
      mean_avg = (items.sum / items.length.to_f)
      squares = items.map { |num| (num - mean_avg) ** 2 }
      Math.sqrt(squares.sum / (items.length.to_f - 1))
    end
  end

  def self.percent(value, total_value)
    (value / total_value.to_f * 100).round(2)
  end
end
