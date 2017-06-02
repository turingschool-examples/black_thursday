require_relative './sales_engine'

class SalesAnalyst

  attr_reader :se
  def initialize(se)
    @se = se
  end

  def average_items_by_merchant
    mr = se.merchants.all
    ir = se.items.all

    (ir.length)/(mr.length)
  end

  def 
end
