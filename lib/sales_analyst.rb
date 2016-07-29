require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    merchant_ids = engine.merchants.all.map { |m| m.id }
    total_items_per_merchant = merchant_ids.reduce(0) do |sum, id|
      sum += engine.find_all_items_by_merchant_id(id).length
    end
    total_merchants = engine.total_merchants
    total_items_per_merchant.to_f / total_merchants.to_f
  end

end
