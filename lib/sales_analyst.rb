require_relative './sales_engine'
require_relative './merchant_repo'
require_relative './item_repo'
require_relative './merchant'
require_relative './item'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
end
