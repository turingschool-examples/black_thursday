# frozen_string_literal: true

# Uses the sales engine to perform calculations
class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
end
