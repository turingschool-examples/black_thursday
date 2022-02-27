require "./lib/merchant_repo"
require "./lib/item_repo"
require "./lib/sales_engine"
require "bigdecimal"
require 'descriptive_statistics'

class SalesAnalyst
  def initialize
  end

  def average_items_per_merchant
    @ir.all.count / @mr.all.count
  end

  def average_items_per_merchant_standard_deviation
 #    samples = [1, 2, 2.2, 2.3, 4, 5]
 # => [1, 2, 2.2, 2.3, 4, 5]
 #    samples.sum
 # => 16.5
 #    samples.mean
 # => 2.75
 #    samples.variance
 # => 1.7924999999999998
 #    samples.standard_deviation
 # => 1.3388427838995882
  end
end
