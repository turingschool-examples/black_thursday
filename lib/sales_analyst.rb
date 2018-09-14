require 'pry'

class SalesAnalyst
  attr_reader :se,
              :mr,
              :ir

  def initialize(se)
    @se = se
    @mr = @se.merchants
    @ir = @se.items
  end

  def average_items_per_merchant
    (@ir.all.count.to_f/@mr.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    # access the @ir-hash and find the quantity of items per merchant
     binding.pry
    # iterate over each item per 1 merchant
  end
end
