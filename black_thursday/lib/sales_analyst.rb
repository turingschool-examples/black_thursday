require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (count_items / count_merchants).round(2)
  end

  private
  def count_merchants
    @engine.merchants.all.count.to_f
  end

  def count_items
    @engine.items.all.count.to_f
  end
end
