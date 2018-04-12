class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (total_items_per_merchant.inject(:+) / total_merchants.to_f).round(2)
  end

  private

  def total_items_per_merchant
    @engine.merchants.all.map do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def total_merchants
    @engine.merchants.all.length
  end
end
