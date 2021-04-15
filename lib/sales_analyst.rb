require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.merchants.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.merchants.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    #return an array of merchant objects > 1 std deviation above avg # of
    #products offered
    # 1 std deviation = standard_deviation + avg
    # so anything greater than the number above will work
    # I added an item called Pixie Dust to the items csv so 1 merchant has 2 items. merchant_id = 12334105

    #need assistance with pulling down the merchant objects that match >1 std deviation criteria
  end
end
