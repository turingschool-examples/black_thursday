# require "./lib/merchant_repo"
# require "./lib/item_repo"
require "sales_engine"
require "bigdecimal"
require 'descriptive_statistics'

class SalesAnalyst #< SalesEngine
  # attr_reader :merchants_instances_array, :items_instances_array

  def initialize
    # super(data)
    # @items_data = data[:items]
    # @merchants_data = data[:merchants]
    # @merchants_instances_array = super.merchants_instances_array
    # @items_instances_array = super.items_instances_array
    @ir = ir
    @mr = mr
  end

  def average_items_per_merchant
    (items_instances_array.count.to_f / merchants_instances_array.count.to_f).round(2)
    # super.items
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
