class SalesAnalyst
  attr_reader :engine
  def initialize(engine = nil)
    @engine = engine
  end
  def average_items_per_merchant
    item_amount = @engine.merchants.all.map do |merchant|
      @engine.find_all_by_merchant_id(merchant.id).length
    end
    (item_amount.sum / item_amount.length.to_f).round(2)
  end
end
