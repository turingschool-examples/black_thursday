class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.items.length.to_f/sales_engine.merchants.merchants.length).round(2)
  end

  def sum(array)
    array.reduce(0) { |sum, item| sum + item }
  end

  def average(array)
    sum(array)/array.length.to_f
  end

  def standard_deviation(array)
    average = average(array)
    sum_squares = array.reduce(0) do |sum, item|
      sum + (item - average)**2
    end
    result = sum_squares/(array.length - 1).to_f
    Math.sqrt(result).round(2)
  end

end
