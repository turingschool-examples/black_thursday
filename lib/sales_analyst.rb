require_relative './sales_engine'

class SalesAnalyst

  attr_reader :se
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    mr = se.merchants.all
    ir = se.items.all

    average = (ir.length.to_f)/(mr.length)
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = {}

    mr = se.merchants.all

    mr.each_with_index do |merchant, idx|
      items = se.items_by_merchant_id(merchant.id)
      merchant_items[idx] = items.length
    end
    merchant_items
  end
end
