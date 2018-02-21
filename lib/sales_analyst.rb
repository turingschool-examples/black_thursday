# frozen_string_literal: true

require_relative 'standard_deviation'

# Uses the sales engine to perform calculations
class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_item_cost
    items = @sales_engine.items.all
    costs = items.map { |item| item.unit_price.to_f }
    costs.reduce(:+) / costs.length.to_f
  end

  def item_cost_standard_deviation
    items = @sales_engine.items.all
    costs = items.map { |item| item.unit_price.to_f }
    StandardDeviation.calculate costs
  end

  def golden_items
    standard_deviation = item_cost_standard_deviation
    average_price = average_item_cost

    @sales_engine.items.all.select do |item|
      item.unit_price >= (average_price + standard_deviation * 2)
    end

  end
end
