require './lib/sales_engine'

class SalesAnalyst

  def initialize(sales_engine = "")
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.merchants.merchants.map do |id, merchant|
      @sales_engine.items.find_all_by_merchant_id(id).count
    end
  end

end


se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

sa = SalesAnalyst.new(se)

p sa.average_items_per_merchant
