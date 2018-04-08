# frozen_string_literal: true

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    all_items = @sales_engine.merchants.all.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant.id).items.length
    end
    all_items.inject(:+).to_f / @sales_engine.merchants.all.length
  end
end
