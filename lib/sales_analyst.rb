require_relative './sales_engine'
require 'descriptive_statistics'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.all_items.length.fdiv(@sales_engine.all_merchants.length).round(2)
  end

  def number_items_per_merchant
    @sales_engine.all_merchants.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def std_dev 

  end

  def average_items_per_merchant_standard_deviation
    self.number_items_per_merchant.standard_deviation.round(2)
  end
end
