require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    engine.items_by_merchant.reduce(&:+) / engine.total_merchants.to_f
  end

end
