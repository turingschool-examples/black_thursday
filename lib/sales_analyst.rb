require_relative 'math_methods'

class SalesAnalyst
  include MathMethods
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    amount_of_items = @sales_engine.items.collection.length
    amount_of_merchants = @sales_engine.merchants.collection.length
    average(amount_of_items, amount_of_merchants)
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant
  end

  def each_merchants_total_items
    @sales_engine.merchants.collection.map
  end

  def single_merchants_total_items(desired_id)
    @sales_engine.items.collection.values.find_all do |item|
      if item.merchant_id == desired_id
        item
      end
    end.length
  end
end
