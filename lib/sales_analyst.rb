require_relative 'sales_engine.rb'

class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    all_merchants = self.engine.merchants.find_all_by_name('')
    total_items = all_merchants.map do |merchant|
      merchant.items.length
    end.sum.to_f
    return (total_items/all_merchants.length).round(2)
  end
end
