require './lib/sales_engine'

class SalesAnalyst

  def initialize(sales_engine = "")
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    long_number = item_array_maker.reduce(0) do |sum, number|
      sum += number
    end/item_array_maker.count.to_f
    long_number.round(2)
  end

  def item_array_maker
    @sales_engine.merchants.merchants.map do |id, merchant|
      @sales_engine.items.find_all_by_merchant_id(id).count
    end
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    square = item_array_maker.map do |item|
      (item-mean) ** 2
    end.sum
    (square/(item_array_maker.count-1)) ** (0.5)
  end
end


se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

sa = SalesAnalyst.new(se)

p sa.average_items_per_merchant_standard_deviation
