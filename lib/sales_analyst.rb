require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def all_prices
    sales_engine.items.all.inject(0) do |sum, object|
      sum + object.unit_price_to_dollars
    end
  end

end
