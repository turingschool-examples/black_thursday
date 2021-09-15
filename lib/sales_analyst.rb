require 'csv'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize#(sales_engine)
    # @sales_engine = sales_engine
    @ir = ItemRepository.new('./data/items.csv')
    @mr = MerchantRepository.new('./data/merchants.csv')
  end

  def average_items_per_merchant
    (@ir.all.length.to_f/@mr.all.length.to_f).round(2)
  end



end
