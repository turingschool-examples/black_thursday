require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    items_per_merch = @sales_engine.all_items.group_by { |item| item.merchant_id }
      require 'pry'; binding.pry
  end

  def average_items_per_merchant

  end
end
