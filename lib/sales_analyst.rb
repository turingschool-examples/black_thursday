require_relative 'sales_engine'
require_relative 'standard_deviation'

class SalesAnalyst
  include StandardDeviation

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine    
  end

  def average_items_per_merchant_standard_deviation
    sample_set = []
      merchants_and_items = sales_engine.merchants.all.map do |merchant|
        sample_set << sales_engine.find_all_items_by_merchant_id(merchant.id).count
      end
    standard_deviation(sample_set).round(2)
  end
  
end