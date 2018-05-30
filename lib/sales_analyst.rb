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

  # def average(first_list, seond_list)
  #   (first_list.to_f / seond_list.to_f).round(2)
  # end
end
