require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

end
