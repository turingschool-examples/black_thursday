require "merchant_repo"
require "item_repo"
require "bigdecimal"
require 'descriptive_statistics'
require 'pry'

class SalesAnalyst
  attr_reader :items, :merchants, :invoices

  def initialize(items, merchants, invoices)
    @items = items
    @merchants = merchants
    @invoices = invoices
    # super(data)
    # @items_data = data[:items]
    # @merchants_data = data[:merchants]
    # @item_repo = item_repo
    # @merchant_repo = merchant_repo
    # @merchants_instances_array = merchants_instances_array
    # @items_instances_array = items_instances_array
    # @items_instanciator = items_instanciator
    # @se = SalesEngine.new({items: items, merchants: merchants})
    # @ir = ItemRepository.new(items_instanciator)
    # @mr = MerchantRepository.new(@merchants_instanciator)
  end

  def average_items_per_merchant
    (items.all.count.to_f / mr.all.count.to_f).round(2)
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
