class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sos = engine.merchants.all.reduce(0) do |sum, merchant|
      sum + (merchant.items.count - average_items_per_merchant)**2
    end
    variance = sos / (engine.merchants.all.count - 1)
    (Math.sqrt(variance)).round(2)
  end
end
