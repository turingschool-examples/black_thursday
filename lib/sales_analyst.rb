require "merchant_repo"
require "item_repo"
require "sales_engine"
require "bigdecimal"
require 'descriptive_statistics'

class SalesAnalyst #< SalesEngine
  attr_reader :ir, :mr, :items_instanciator, :merchants_instances_array, :items_instances_array

  def initialize
    # super(data)
    # @items_data = data[:items]
    # @merchants_data = data[:merchants]
    # @item_repo = item_repo
    # @merchant_repo = merchant_repo
    # @merchants_instances_array = merchants_instances_array
    # @items_instances_array = items_instances_array
    # @items_instanciator = items_instanciator
    # @se = SalesEngine.new({items: items, merchants: merchants})
    @ir = ItemRepository.new(items_instanciator)
    @mr = MerchantRepository.new(@merchants_instanciator)
  end

  def average_items_per_merchant
    # se
    # (ir.all.count.to_f / mr.all.count.to_f).round(2)
    ir
    # super.items
    # @item_repo
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
