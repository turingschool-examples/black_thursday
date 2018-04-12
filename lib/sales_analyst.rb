class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (total_items_per_merchant.reduce(:+) / total_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    result = total_items_per_merchant.map do |items|
      (items - average_items_per_merchant) ** 2
    end
    calculated = result.reduce(:+).to_f / (total_items_per_merchant.length - 1)
    Math.sqrt(calculated).round(2)
  end

  private

  def total_items_per_merchant
    @total ||= @engine.merchants.all.map do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def total_merchants
    @engine.merchants.all.length
  end
end
