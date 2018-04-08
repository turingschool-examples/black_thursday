# frozen_string_literal: true

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant_item_array = []
    all_items = @sales_engine.merchants.all.map do |merchant|
      merchant = @sales_engine.merchants.find_by_id(merchant.id)
      merchant_item_array = merchant.items
      merchant_item_array.length
    end
    all_items.inject(:+)

  end

end
